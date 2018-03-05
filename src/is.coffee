#
# type name extractor
#
exports._name = ( x ) -> 
    return 'Undefined' if typeof x == 'undefined'
    return 'Null' if x == null
    x.constructor.name


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
        if @[scope]? and 'Function' == this._name @[scope]
            throw new Error "@eoln/types.register: scope `#{scope}` conflicts"
        
        # initialize scope
        @[scope] = {} unless @[scope]?

        # update root pointer
        root = @[scope]

    # extract type's name
    nx = @_name x

    # finish if name already registered in root pointer 
    # return @ if root[nx]?

    # create type checker at root pointer
    root[nx] = (y) => nx == @_name y 

    @


#
# js (native) values

jsValues = [
    []              # is.Array
    true            # is.Boolean
    new Date()      # is.Date
    () -> ''        # is.Function
    null            # is.Null
    1.0             # is.Number
    {}              # is.Object
    /./             # is.RegExp
    ''              # is.String
    Symbol()        # is.Symbol
    undefined       # is.Undefined
];


#
# register js(native) types in global scope
#
jsValues.forEach (v) -> exports._register v
