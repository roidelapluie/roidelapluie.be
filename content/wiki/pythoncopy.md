+++
title = "Python dict() copy"
lang = "en"
date = "2014-12-24T16:27:14"
+++

    $ python
    Python 2.7.8 (default, Oct 14 2014, 11:42:50) 
    [GCC 4.8.2] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>> a={'a':{'b':'c'},'d':0}
    >>> a
    {'a': {'b': 'c'}, 'd': 0}
    >>> b=a
    >>> c=dict(a)
    >>> b
    {'a': {'b': 'c'}, 'd': 0}
    >>> c
    {'a': {'b': 'c'}, 'd': 0}
    >>> c['d']=1
    >>> c
    {'a': {'b': 'c'}, 'd': 1}
    >>> a
    {'a': {'b': 'c'}, 'd': 0}
    >>> c['a']['b']='f'
    >>> c
    {'a': {'b': 'f'}, 'd': 1}
    >>> a
    {'a': {'b': 'f'}, 'd': 0}
    >>> import copy
    >>> c=copy.deepcopy(a)
    >>> a
    {'a': {'b': 'f'}, 'd': 0}
    >>> c
    {'a': {'b': 'f'}, 'd': 0}
    >>> c['d']=1
    >>> c
    {'a': {'b': 'f'}, 'd': 1}
    >>> a
    {'a': {'b': 'f'}, 'd': 0}
    >>> c['a']['b']='f'
    >>> c['a']['b']='g'
    >>> c
    {'a': {'b': 'g'}, 'd': 1}
    >>> a
    {'a': {'b': 'f'}, 'd': 0}
    >>> 

