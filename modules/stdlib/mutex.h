
typedef struct __local_pthread_mutex_t {
  int spinlock;
  int mutex_type;
  int owner_thread_id;
  int recursion_counter;
  int mutex_handle;
} _LOCK_T;
typedef _LOCK_T _LOCK_RECURSIVE_T;

typedef _LOCK_T Mutex;
typedef _LOCK_RECURSIVE_T RMutex;
