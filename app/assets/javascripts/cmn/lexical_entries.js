$(document).ready(ready);
$(document).on('page:load', ready);

// Multiple element selection and action using checkboxes in cmn/lexical_entries#add #search
//
function ready() {
    console.log("Document Ready !!");

    refreshButtons();

    // Select or deselect all checkboxes whenever the top checkbox is clicked.
    //
    $("#select-all").click(function() {
        $(".table td :checkbox").each(function() {
            this.checked = $("#select-all").prop("checked");
        });
        refreshButtons();
    });

    // Set top checkbox to indeterminate whenever a row checkbox is clicked.
    //
    $('.table td :checkbox').click(function() {
        var selectAll = $('#select-all');
        if (selectAll.is(':checked') && !$(this).is(':checked')) {
            if (someCheckboxChecked()) {
                selectAll.prop('indeterminate', true);
            } else {
                selectAll.prop('checked', false);
                selectAll.prop('indeterminate', false);
            }
        } else if (!selectAll.is(':checked') && $(this).is(':checked')) {
            selectAll.prop('checked', true);
            selectAll.prop('indeterminate', true);
        }
        refreshButtons();
    });

    // Show edit and delete multiple buttons only when at least one checkbox is
    // checked.
    //
    function refreshButtons() {
        if (someCheckboxChecked())
            //$('.collection-action').show();
            $('.collection-action button').removeClass("disabled");
        else
            //$('.collection-action').hide();
            $('.collection-action button').addClass("disabled");
    }

    function someCheckboxChecked() {
        var checkboxes = $('.table td :checkbox');
        for (var i = 0 ; i < checkboxes.length ; i++) {
            var checkbox = checkboxes.get(i);
            if (checkbox.checked)
                return true;
        }
        return false;
    }

    $("#select-multiple").click(function() {
        var url = lexicalEntriesPath() + "/select_multiple";
        submitTableForm(url);
    });

    $("#deselect-multiple").click(function() {
        var url = lexicalEntriesPath() + "/deselect_multiple";
        submitTableForm(url);
    });

    $("#destroy-multiple").click(function() {
        var url = lexicalEntriesPath() + "/destroy_multiple";
        submitTableForm(url);
    });

    $("#edit-multiple").click(function() {
        var url = lexicalEntriesPath() + "/edit_multiple";
        submitTableForm(url);
    });

    function submitTableForm(url) {
        $('#table-form').prop('action', url);
        $('#table-form').submit();
    }


    function lexicalEntriesPath() {
        var lexicalEntriesRegexp = /.*\/[a-z]{3}\/lexicons\/\d+\/lexical_entries/;
        var currentUrl = $(location).prop('href')
        var match = lexicalEntriesRegexp.exec(currentUrl);
        return match[0];
    }


    var lexicalEntriesRegexp = /\/[a-z]{3}\/lexicons\/(\d+)\/lexical_entries/;
    function lexiconId() {
        var currentUrl = $(location).prop('href')
        var match = lexicalEntriesRegexp.exec(currentUrl);
        return match[1];
    }

}

