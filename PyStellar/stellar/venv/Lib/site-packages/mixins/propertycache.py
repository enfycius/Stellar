from typing import Callable

class SimplePropertyCacheMixin:
    """
    Supports caching properties.
    """

    def _try_getattr_else_call_func(self, attr: str, func: Callable, *func_args, **func_kwargs):
        try:
            return getattr(self, attr)
        except AttributeError:
            func(*func_args, **func_kwargs)

        return getattr(self, attr)