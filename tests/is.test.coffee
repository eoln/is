$is = require '../src/is'

describe 'is', () ->
    js = [
        { v: [],                 t:'Array' }
        { v: true,               t:'Boolean' }
        { v: new Date(),         t:'Date' }
        # Date is a function
        { v: Date,               t:'Function' }
        { v: null,               t: 'Null' }
        { v: 1.0,                t: 'Number' }
        { v: Promise.resolve(),  t: 'Promise'}
        { v: {},                 t: 'Object' }
        { v: /./,                t: 'RegExp' }
        { v: '',                 t: 'String' }
        { v: Symbol(),           t: 'Symbol'    }
        { v: undefined,          t: 'Undefined' }
    ];

    describe 'layout', () ->
        props = [
            # methods
            '_name'
            '_register'

            # registered native types
            'Array'
            'Boolean'
            'Date'
            'Function'
            'Null'
            'Number'
            'Promise'
            'Object'
            'RegExp'
            'String'
            'Symbol'
            'Undefined'
        ]

        # all props should be defined
        props.forEach (p) ->
            it "property #{p}", () ->
                expect($is[p]).toBeDefined()
                expect(typeof $is[p]).toBe('function')

                



    describe '_name', () ->

        it 'should be a Function', () ->
            expect( typeof $is._name ).toBe 'function'

        describe 'should recognize native js types', () ->
            js.forEach (d)->
                it "-> #{d.t}", () ->
                    expect($is._name d.v).toEqual d.t

        it 'should recognize the type of custom class', () ->
            class NewClass
            expect($is._name new NewClass).toEqual 'NewClass'



    describe '_register', () ->

        it 'should be a Function', () ->
            expect( typeof $is._register ).toBe 'function'

        describe 'register native js types', () ->
            js.forEach (d)->
                it "-> #{d.t}", () ->
                    delete $is[d.t]
                    expect($is[d.t]).toBeFalsy()
                    rv = $is._register d.v
                    expect(rv).toEqual $is
                    expect(typeof $is[d.t]).toBe 'function'
                    rv = $is._register d.v, 'internal'
                    expect(rv).toEqual $is
                    expect($is.internal).toBeDefined()
                    expect(typeof $is.internal[d.t]).toBe 'function'


        it 'should throws error on scope conflicts', () ->
            expect( -> $is._register 1, 'Undefined' ).toThrow()
            undefined

        it 'should be able to register custom class', () ->
            class Class2
            $is._register new Class2
            expect(typeof $is.Class2).toBe 'function'

