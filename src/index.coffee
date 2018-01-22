#
# type name extractor
#
exports._name = ( x ) -> 
    return 'Undefined' if typeof x == 'undefined'
    return 'Null' if x == null
    if typeof x == 'function' then x.name else x.constructor.name


#
# registers type in scope by value or class function
#
exports._register = ( x, scope ) ->

    # root pointer by default points at global scope
    root = @

    # init scope if necessary
    if scope?.length > 0

        # throw when scope conflicts with js native types
        # below in this file the js native types are registered
        if typeof @[scope] != 'object'
            throw new Error "@eoln/types.register: scope `#{scope}` conflicts"
        
        # initialize scope
        @[scope] = {} unless @[scope]?

        # update root pointer
        root = @[scope]

    # extract type's name
    nx = @_name x

    # finish if name already registered in root pointer 
    return @ if root[nx]?

    # create type checker at root pointer
    root[nx] = (y) => nx == @_name y 

    @


#
# js (native) values
#
jsValues = [
    {}              # is.Object
    []              # is.Array
    () -> ''        # is.Function
    1.0             # is.Number
    ''              # is.String
    true            # is.Boolean
    null            # is.Null
    undefined       # is.Undefined
    new Date()      # is.Date
    /./             # is.RegExp
    Symbol()        # is.Symbol
]


#
# register js(native) types in global scope
#
jsValues.forEach (v) -> exports._register v
