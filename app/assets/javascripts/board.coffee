# Just a log helper
log = (args...) ->
  console.log.apply console, args if console.log?

# ---- Card View

$ ->

  cardTemplate = $("#card-template")
  cardListTemplate = $("#card-list-template")
  newCardFormTemplate = $("#new-card-form-template")
  enableSortOnCardBoard = (spanSize) ->
    _ph = "placeholder list-height span" + spanSize
    $(".card-board").sortable axis: "x", placeholder: _ph

  enableSortOnCardList = ->
    $("div.card-list-body").sortable
      connectWith: ".card-list-body"
      placeholder: "placeholder well"

  addCardList = ->
    existedCardList = $("#card-board > div.card-list")
    size = existedCardList.size()
    existedCardList.removeClass("span3").addClass("span2") if 4 == size
    newListData = {}
    newCardList = cardListTemplate.tmpl(newListData)

    if  size < 4 then newListData.spanSize = 3
    else if size == 4 then newListData.spanSize = 2
    else if size > 6 then newListData.spanSize = 2
    else
      alert "No More Space!"
      return
    newCardList.find(".btn-add-card").click(addCardBtnClick)
    newCardList.appendTo("#card-board")
    enableSortOnCardBoard newListData.spanSize
    enableSortOnCardList()

  addCard = (cardListBody, content) ->
    cardTemplate.tmpl({'content': content}).appendTo(cardListBody)

  addCardBtnClick = ->
    $btn_newCard = $(this)
    $btn_newCard.hide()
    $form = newCardFormTemplate.tmpl()
    $form.insertBefore $btn_newCard
    $btnSave = $form.find "input.btn-save"
    $input = $form.find("input.new-card-content").focus()
    cardListBody = $btn_newCard.parent(null).siblings(".card-list-body")

    $form.submit (e) ->
      e.preventDefault()
      if $input.val().trim()
        addCard cardListBody, $input.val()
        $input.parent().removeClass "error"
        @reset()
      else
        $input.parent().addClass "error"

    $input.blur ->
      if $input.val().trim() == ""
        $btn_newCard.show()
        $form.remove()

  enableSortOnCardBoard 4
  enableSortOnCardList()
  $(".card-list-footer > .btn-add-card").click addCardBtnClick
  $("#menu-add-list").click addCardList
