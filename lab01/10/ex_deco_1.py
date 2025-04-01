#ex_deco_1.py

import time

#print(time, time())

fibonacci_dp = timing_decorator(fibonacci_dp)

def timing_decorator(func):
        def wrapper(*args, **kwargs):
                start_time= time.time()
                result = func(*args, **kwargs)
                end_time= time.time()
                print(f"{func.__name__}실행 시간: {end_time-start_time:.5f}초")
                return result
        return wrapper


def fibonacci_dp(n):
        return fibonacci_dp

@timing_decorator
def fibonacci(n):
        a,b = 0,1
        yield a
        a,b = b, a+b
        print(f"a:{a},b: {b}")

@timing_decorator
def fibonacci_deco(n):
        return[_ for _ in fibonacci(n)]

# fibonacci_dp = timing_decorator(fibonacci_dp)
fibonacci_dp(4000)
fibonacci_deco(4000)