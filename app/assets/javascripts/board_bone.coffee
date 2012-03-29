$ ->
    class Board extends Backbone.Model
        defaults:
            title: "Undefined Board"

    class Column extends Backbone.Model
        defaults:
            title: "Untitled Column"

    class ColumnView extends Backbone.View

        initialize: (options)=>
            @model = options.model
            @render();
        
        render: =>
            $(@el).html _.template $("#card-list-template").html(), 
                title: @model.get("title") 

    class BoardView extends Backbone.View

        initialize: (options) =>
            @el = $(options.el)
            @model = options.model

        addColumn: =>
            columnView = new ColumnView model:new Column
            @el.append columnView.el

    class AppRouter extends Backbone.Router

        initialize: (options) =>
            @currentBoard = options.currentBoard
        routes:
            "addColumn" : "addColumn"
        addColumn: =>
            alert "route.addColumn"
            @currentBoard.addColumn()
    
    window.appRoute = new AppRouter 
        currentBoard : new BoardView
                            model: new Board
                            el : "#board"
    Backbone.history.start();