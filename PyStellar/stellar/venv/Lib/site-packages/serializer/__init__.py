from xml.dom.minidom import Document
try:
    import simplejson as _json
except ImportError:
    import json as _json


class Empty():
    pass


empty = Empty()


def is_callable(object):
    _type = type(object).__name__
    return _type == 'instancemethod' or _type == 'function'


def dumps(value, args):
    if is_callable(value):
        value = value()
    value = dump_object(value, args)
    return value


class Dict2XML(object):
    """
    Slightly modified version of
    http://code.activestate.com/recipes/577739-dict2xml/
    """

    def __init__(self, structure):
        self.doc = Document()

        if len(structure) == 1:
            root_name = str(structure.keys()[0])
            self.root = self.doc.createElement(root_name)

            self.doc.appendChild(self.root)
            self.build(self.root, structure[root_name])

    def build(self, father, structure):
        if isinstance(structure, dict):
            for key in structure:
                tag = self.doc.createElement(key)
                father.appendChild(tag)
                self.build(tag, structure[key])

        elif isinstance(structure, list):
            grand_father = father.parentNode
            tag_name = father.tagName
            grand_father.removeChild(father)
            for key in structure:
                tag = self.doc.createElement(tag_name)
                self.build(tag, key)
                grand_father.appendChild(tag)

        else:
            data = str(structure)
            tag = self.doc.createTextNode(data)
            father.appendChild(tag)

    def __call__(self, *args, **kwargs):
        return self.doc.toprettyxml(*args, **kwargs)


class Serializable(object):
    """
    This class mimics the functionality found in RoR ActiveModel.
    For more info see:
    http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html
    """

    def attributes(self):
        """
        This method is being used by as_json for defining the default json
        attributes for this model.

        Serializable objects can override this and return a list of desired
        default attributes.

        Examples::

            >>> User(Serializable):
            ...     def __init__(name, age):
            ...         self.name = name
            ...         self.age = age
            ...
            ...     def attributes(self):
            ...         return ['name', 'age']
            ...
            >>> User('John', 50).as_json()
            {'name': 'John', 'age': 50}
        """
        return []

    def attribute_sets(self):
        """
        This method should return a dict with keys as attribute set names and
        values as desired attribute sets

        Attribute sets can be used as a convenient shortcuts in as_json()

        Examples::

            >>> User(Serializable):
            ...     def attribute_sets(self):
            ...         return {'details': ['id', 'name', 'age']}
            >>> User(id=1, name='someone',).as_json(only='details')
            {'id': 1, 'name': 'Someone', 'age': 14}
        """
        return {}

    def to_xml(self, only=None, exclude=None, include=None, **kwargs):
        """
        Returns the object attributes serialized in xml format

        :param only: a list containing attribute names to only include in the
                     returning xml
        :param exclude: a list containing attributes names to exclude from the
                        returning xml
        :param include: a list containing attribute names to include in the
                        returning xml
        """
        return Dict2XML(
            self.as_json(only=only, exclude=exclude, include=include)
        )(**kwargs)

    def to_json(self, only=None, exclude=None, include=None):
        """
        Returns the object attributes serialized in json format

        :param only: a list containing attribute names to only include in the
                     returning json
        :param exclude: a list containing attributes names to exclude from the
                        returning json
        :param include: a list containing attribute names to include in the
                        returning json
        """
        return _json.dumps(self.as_json(), use_decimal=True)

    def as_json(self, only=None, exclude=None, include=None):
        """
        Returns object attributes as a dictionary with jsonified values

        :param only: a list containing attribute names to only include in the
                     returning dictionary
        :param exclude: a list containing attributes names to exclude from the
                        returning dictionary
        :param include: a list containing attribute names to include in the
                        returning dictionary

        Without any options, the returned JSON string will include all the
        fields returned by the models attribute() method. For example:

        >>> class User(Serializable):
        ...    def attributes(self):
        ...        return [
        ...            'id',
        ...            'first_name',
        ...            'last_name'
        ...        ]
        ...
        >>> user = User()
        >>> user.first_name = 'John'
        >>> user.last_name = 'Matrix'
        >>> user.as_json()
        {"id": 1, "first_name": "John", "last_name": "Matrix"}

        The 'only' and 'exclude' options can be used to limit the attributes
        included. For example:

        >>> user.as_json(only=['id', 'first_name'])
        {"id": 1, "first_name": "John"}

        >>> user.as_json(exclude=['id'])
        {"first_name": "John", "last_name": "Matrix"}

        To include the result of some additional attributes, method calls,
        attribute sets or associations on the model use 'include'.

        >>> user.weight = 120
        >>> user.as_json(include=['weight'])
        {"id": 1, "first_name": "John", "last_name": "Matrix", "weight": 120}

        Sometimes its useful to assign aliases for attributes. This can be
        achieved using keyword 'as'.

        >>> user.as_json(only=['first_name as alias'])
        {"alias": "John"}

        In order to fine grain what gets included in associations you can use
        'include' parameter with additional arguments.

        >>> user.as_json(include=[('posts', {'include': 'details'})]
        {
            "id": 1,
            "name": "John Matrix",
            "first_name": "John",
            "last_name": "Matrix",
            "weight": 100,
            "posts": [
              {"id": 1, "author_id": 1, "title": "First post"},
              {"id": 2, author_id: 1, "title": "Second post"}
            ]
        }

        Second level and higher order associations work as well:

        >>> user.as_json('include'= [('posts',
        ...      {
        ...       'include': [
        ...               ('comments', {'only': ['body']})
        ...           ],
        ...       'only': ['title']
        ...       }
        ... )]
        {
            "id": 1,
            "first_name": "John",
            "last_name": "Matrix",
            "weight": 100,
            "posts": [
                {
                    "comments": [
                        {"body": "1st post!"}, {"body": "Second!"}
                    ],
                    "title": "Welcome to the weblog"
                },
            ]
        }
        """
        return serialize(self, only=only, exclude=exclude, include=include)


def serialize(serializable, only=None, exclude=None, include=None):
    """
    Serializes given object

    :param serializable: object to be serialized
    :param only: list of attributes to be included in json, if this parameter
        is not set attributes() method of the model will be used for obtaining
        the list of attributes names
    :param exclude: list of attributes to be excluded from the serialized
        format
    :param include: list of attribute names to be included in serialized hash,
        attribute names can be any properties of `serializable` (even method
        names)
    """
    serialized = {}
    if only:
        serialized.update(
            serialize_iterable(serializable, only)
        )
    else:
        serialized.update(
            serialize_iterable(
                serializable, serializable.attributes(), exclude
            )
        )
    if include:
        serialized.update(serialize_iterable(serializable, include))

    return cleanup(serialized)


OBJECT_DUMPERS = {
    Serializable: lambda a, b: serialize(a, **copy_args(b)),
    'datetime': lambda a, b: a.strftime('%Y-%m-%dT%H:%M:%SZ') if a else None,
    'date': lambda a, b: a.isoformat() if a else None,
    list: lambda a, b: [dumps(c, b) for c in a],
}


def register_dumper(key, dumper_callable):
    """
    Registers new dumper for given class type

    Examples::
        >>> class MyClassA(object):
        ...     pass
        >>> class MyClassB(MyClassA):
        ...     pass
        >>> register_dumper('MyClassA', lambda a: 'myclass')
        >>> dump_object(MyClassA())
        "myclass"
        >>> dump_object(MyClassB())
        <MyClassB instance>


        >>> class MyClassA(object):
        ...     pass
        >>> class MyClassB(MyClassA):
        ...     pass
        >>> register_dumper(MyClassA, lambda a: 'myclass')
        >>> dump_object(MyClassA())
        "myclass"
        >>> dump_object(MyClassB())
        "myclass"
    """
    OBJECT_DUMPERS[key] = dumper_callable


def dump_object(value, args):
    """
    Serializes a non callable variable

    Examples::
        >>> dump_object(datetime(2000, 11, 11))
        "2000-11-11 00:00:00Z"
    """
    #print value, args
    for class_ in OBJECT_DUMPERS:
        if isinstance(class_, basestring):
            if class_ == value.__class__.__name__:
                value = OBJECT_DUMPERS[class_](value, args)
        elif isinstance(value, class_):
            value = OBJECT_DUMPERS[class_](value, args)
    return value


def copy_args(args):
    copy_args = {}
    if 'only' in args:
        copy_args['only'] = args['only']
    if 'include' in args:
        copy_args['include'] = args['include']
    if 'exclude' in args:
        copy_args['exclude'] = args['exclude']
    return copy_args


def unpack_args(args):
    """
    unpacks args

    Used by jsonifiers
    """
    if isinstance(args, tuple):
        return args
    else:
        return (args, {})


def unpack_key(key):
    """
    Unpacks given key

    For example the unpacked format of key "key as key1" is
    {
        'name': 'key',
        'alias': 'key1'
    }
    """
    parts = key.split(' as ')
    if len(parts) == 1:
        parts.append(parts[0])
    return parts


def cleanup(serialized):
    """
    Remove all missing values. Sometimes its useful for object methods
    to return missing value in order to not include that value in the
    json format.

    Examples::

        >>> User(Serializable):
        ...     def attributes():
        ...         return ['id', 'name', 'birthday', 'somefunc']
        ...     def age():
        ...         if birthday:
        ...             return empty
        ...         else:
        ...             return calc_age(self.birthday)


    Now if some user has birthday the age function is going to return the age.
    However if user doesn't have birthday the age function is returning a
    special empty value which tells jsonifier not to include that key in
    json format.

        >>> User(id=1, name='someone').as_json()
        {'id': 1, 'name': 'Someone'}
    """
    return dict(filter(lambda a: a[1] is not empty, serialized.items()))


def serialize_iterable(serializable, iterable, exclude=None):
    """
    serialize iterable

    :param serializable: serializable obj of which the iterable belong to
    :param iterable: attributes as iterable
    :param exclude: excluded attributes
    """
    attr_sets = serializable.attribute_sets()
    serialized = {}

    for key, args in map(unpack_args, iterable):
        if exclude and key in exclude:
            continue
        if key in attr_sets:
            subattrs = attr_sets[key]
            for key, subargs in map(unpack_args, subattrs):
                model_attr, alias = unpack_key(key)
                serialized[alias] = serialize_attribute(
                    serializable, model_attr, subargs
                )
        else:
            model_attr, alias = unpack_key(key)
            serialized[alias] = serialize_attribute(
                serializable, model_attr, args
            )
    return serialized


def serialize_attribute(obj, attr, args=None):
    """
    Serializes single object attribute

    :param model: model of which the attribute belongs to
    :param attr: the name of the attribute
    :param args: additional args
    """
    if not args:
        args = {}

    if not hasattr(obj, attr):
        value = empty
    else:
        value = getattr(obj, attr)

    value = dumps(value, args)

    return value
