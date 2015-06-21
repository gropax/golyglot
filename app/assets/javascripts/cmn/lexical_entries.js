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
            $('.collection-action').show();
        else
            $('.collection-action').hide();
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

    $("#destroy-multiple").click(function() {
        $('input#collection_action').val('destroy');
        $('#table-form').submit();
    });

    $("#edit-multiple").click(function() {
        $('input#collection_action').val('edit');
        $('#table-form').submit();
    });

}

