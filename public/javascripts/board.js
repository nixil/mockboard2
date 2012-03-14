$().ready(function () {
    function enableSortOnCardBoard(spanSize) {
        var _ph = "placeholder list-height span" + spanSize;
        $(".card-board").sortable({
            axis:"x",
            placeholder:_ph
        });
    }

    function enableSortOnCardList() {
        $("div.card-list-body").sortable({
            connectWith:".card-list-body",
            placeholder:"placeholder well"
        });
    }

    function addCardList() {
        var currentCardList = $("#card-board > div.card-list");
        var size = currentCardList.size();
        var newListData = {};
        if (4 > size) {
            newListData.spanSize = 3;
        } else if (4 == size) {
            currentCardList.removeClass("span3").addClass("span2");
            newListData.spanSize = 2;
        } else if (6 > size) {
            newListData.spanSize = 2;
        } else {
            alert("No More Space!");
            return;
        }
        var newCardList = $("#card-list-template").tmpl(newListData);
        newCardList.find(".btn-add-card").click(addCardBtnClick);
        newCardList.appendTo("#card-board");
        enableSortOnCardBoard(newListData.spanSize);
        enableSortOnCardList();
    }

    function addCard(cardListBody, content) {
        $("#card-template").tmpl({'content':content}).appendTo(cardListBody);
    }

    var addCardBtnClick = function () {
        var $btn_newCard = $(this);
        $btn_newCard.hide();
        var $form = $("#new-card-form-template").tmpl();
        $form.insertBefore($btn_newCard);
        var $btnSave = $form.find("input.btn-save");
        var $input = $form.find("input.new-card-content").focus();
        var cardListBody = $btn_newCard.parent(null).siblings(".card-list-body");
        $form.submit(function () {
            if ($input.val()) {
                addCard(cardListBody, $input.val());
                this.reset();
            } else {
                $input.parent().addClass("error");
            }
            return false;
        });
        $input.blur(function () {
            if ($input.val() == "") {
                $btn_newCard.show();
                $form.remove();
            }
        });
    };
    enableSortOnCardBoard(4);
    enableSortOnCardList();
    $(".card-list-footer > .btn-add-card").click(addCardBtnClick);
});
