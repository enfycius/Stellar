import json
from typing import Sequence, Any, Tuple


class EqOnAttrsMixin:
    """
    Allows class equality to be compared on the equality of the attribute names listed in equal_attrs.
    """
    equal_attrs = None

    def __eq__(self, other):
        if self.equal_attrs is None:
            return super().__eq__(other)

        for equal_attr in self.equal_attrs:
            if not hasattr(other, equal_attr): # other object doesn't have this property, must not be equal
                return False
            if getattr(self, equal_attr) != getattr(other, equal_attr):
                return False

        # passed all checks, must be equal
        return True


class EqOnAttrsWithConversionMixin(EqOnAttrsMixin):
    """
    Allows class equality to be compared on the equality of the attribute names listed in equal_attrs, converting
    all attributes to convert_type before comparing.
    """
    convert_type = str

    def __eq__(self, other):
        if self.equal_attrs is None:
            return self == other

        for equal_attr in self.equal_attrs:
            if not hasattr(other, equal_attr): # other object doesn't have this property, must not be equal
                return False
            if self.convert_type(getattr(self, equal_attr)) != self.convert_type(getattr(other, equal_attr)):
                return False

        # passed all checks, must be equal
        return True


class EqHashMixin:
    """
    Sets __hash__ based on attributes named in equal_attrs only.
    """
    equal_attrs = None
    _recursive_hash_convert = False

    def __hash__(self):
        if self.equal_attrs is None:
            return super().__hash__()

        contents = [getattr(self, attr) for attr in self.equal_attrs]

        if self._recursive_hash_convert:
            tup_contents = _convert_nested_builtins_to_hashable(contents)
        else:
            tup_contents = tuple(contents)

        return hash(tup_contents)


def _convert_nested_builtins_to_hashable(seq: Sequence) -> Tuple[Any, ...]:
    items = []
    new_item: Any
    for item in seq:
        if isinstance(item, (list, tuple)):
            new_item = _convert_nested_builtins_to_hashable(item)
        elif isinstance(item, dict):
            new_item = json.dumps(item)
        else:
            new_item = item
        items.append(new_item)

    items_tup = tuple(items)

    return items_tup

