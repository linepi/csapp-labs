/* 
 * Name: linepi
 * Email: mmagicode@gmail.com
 */

#include "cachelab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <getopt.h>
#include <assert.h>
#include <stdint.h>
#include <time.h>
#include <limits.h>

#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0

#define NR_BYTE (1 << param.b)
#define NR_SET (1 << param.s)
#define NR_LINE (param.E)
/*
  line layout: 
    [0]   [1:8]   [9:NR_BYTE + 8]
  valid   flag        block
*/
#define LINE_SIZE (1 + 8 + NR_BYTE)

static void parse_args(int, char*[]);
static void helpdump();
static void do_mem();
static void access(int set, uint64_t flag, int block_off);

enum mem_type_t {
  LOAD,
  STORE,
  MODIFY
};

struct {
  bool verbose;
  int s;
  int E;
  int b;
  char file[256];
} param;

struct {
  int hit;
  int miss;
  int evict;
} res;

uint8_t* fast_cache;
clock_t* access_time;

int main(int argc, char *argv[])
{
  parse_args(argc, argv);
  // init cache
  fast_cache = (uint8_t*)calloc(NR_LINE * NR_SET, LINE_SIZE);
  access_time = (clock_t*)malloc(NR_SET * NR_LINE * sizeof(clock_t));

  FILE *fp = fopen(param.file, "r");
  assert(fp);
  char buf[32];
  while (fgets(buf, 31, fp) != 0) {
    enum mem_type_t type;
    uint64_t addr;
    int len;

    char *p = buf;
    while (*p == ' ') p++;
    if (*p == 'S') type = STORE; 
    else if (*p == 'L') type = LOAD; 
    else if (*p == 'M') type = MODIFY; 
    else if (*p == 'I') continue;
    else assert(0);
    p += 2;
    // get addr
    char *pp = p;
    for (; *pp != ','; pp++);
    *pp = '\0';
    addr = (uint64_t)strtol(p, NULL, 16);
    pp++;
    p = pp;
    for (; *pp != '\n'; pp++);
    *pp = '\0';
    len = atoi(p);
    do_mem(type, addr, len);
  }
  printSummary(res.hit, res.miss, res.evict);
  fclose(fp);
  free(fast_cache);
  free(access_time);
  return 0;
}

static void do_mem(enum mem_type_t type, uint64_t addr, int len) {
  assert(type <= MODIFY && type >= LOAD);
  char typemap[] = {
    [LOAD] 'L', 
    [STORE] 'S', 
    [MODIFY] 'M'
  };
  if (param.verbose)
    printf("%c %lx,%d ", typemap[type], addr, len);
  // decode addr
  int block_off = addr & (NR_BYTE - 1);
  int set = (addr >> param.b) & (NR_SET - 1);
  uint64_t flag = addr >> (param.b + param.s);
  // 假设读和写访存的行为相同
  access(set, flag, block_off);
  if (type == MODIFY)
    access(set, flag, block_off);
  if (param.verbose)
    printf("\n");
}

#define VALID(line_start) (*(bool*)line_start)
#define FLAG(line_start) (*(uint64_t*)((uint8_t*)line_start + 1))
#define ACCESS_TIME(line_start) (*(access_time + ((uint8_t*)line_start - fast_cache) / LINE_SIZE))

static void access(int set, uint64_t flag, int block_off) {
  uint8_t *cur_set = fast_cache + set * (NR_LINE * LINE_SIZE);
  uint8_t *cur_set_end = fast_cache + (set + 1) * (NR_LINE * LINE_SIZE); 
  uint8_t *p;
  for (p = cur_set; p != cur_set_end; p += LINE_SIZE) {
    // hit
    if (VALID(p) && FLAG(p) == flag) {
      res.hit++;
      if (param.verbose) printf("hit ");
      ACCESS_TIME(p) = clock();
      return;
    } 
  }
  // do not hit(miss), loop again
  res.miss++;
  if (param.verbose) printf("miss ");
  clock_t min_time = LONG_MAX;
  uint8_t *line_to_be_replace;
  for (p = cur_set; p != cur_set_end; p += LINE_SIZE) {
    if (!VALID(p)) {
      VALID(p) = true;
      FLAG(p) = flag;
      ACCESS_TIME(p) = clock(); 
      return;
    } else {
      if (ACCESS_TIME(p) < min_time) {
        min_time = ACCESS_TIME(p);
        line_to_be_replace = p;
      }
    }
  }
  // eviction will occur
  res.evict++;
  if (param.verbose) printf("eviction ");
  assert(VALID(line_to_be_replace));
  FLAG(line_to_be_replace) = flag;
  // 假设切换一行也算“使用”，记入时间
  ACCESS_TIME(line_to_be_replace) = clock();
}

static void parse_args(int argc, char *argv[]) {
  int option; 
  unsigned char flag = 0;
  while ((option = getopt(argc, argv, "hvs:E:b:t:")) != -1) {
    switch (option) {
      case 'h':
        helpdump();
        exit(EXIT_FAILURE);
      case 'v':
        param.verbose = true;
        break;
      case 's':
        param.s = atoi(optarg);
        flag |= 0b1;
        break;
      case 'E':
        param.E = atoi(optarg);
        flag |= 0b10;
        break;
      case 'b':
        param.b = atoi(optarg);
        flag |= 0b100;
        break;
      case 't':
        strcpy(param.file, optarg);
        flag |= 0b1000;
        break;
      default: 
        helpdump();
        exit(EXIT_FAILURE);
      }
  }
  if (param.verbose)
    printf("params: v:%d s:%d E:%d b:%d t:%s\n", param.verbose, param.s, param.E, param.b, param.file);
  if (flag != 0x0f) {
    helpdump();
    exit(EXIT_FAILURE);
  }
}

static void helpdump() {
  printf("Usage: ./csim [-hv] -s <num> -E <num> -b <num> -t <file>\n");
  printf("Options:\n");
  printf("  -h         Print this help message.\n");
  printf("  -v         Optional verbose flag.\n");
  printf("  -s <num>   Number of set index bits.\n");
  printf("  -E <num>   Number of lines per set.\n");
  printf("  -b <num>   Number of block offset bits.\n");
  printf("  -t <file>  Trace file.\n");
}