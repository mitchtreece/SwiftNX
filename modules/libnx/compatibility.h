// MARK: LOCK_T

typedef int32_t _LOCK_T;

struct __lock_t {
	_LOCK_T lock;
	uint32_t thread_tag;
	uint32_t counter;
};

typedef struct __lock_t _LOCK_RECURSIVE_T;
