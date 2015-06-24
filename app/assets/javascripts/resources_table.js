var ResourcesTable = (function($) {
    var ResourcesTable = {};

    var masterCheckbox,
        checkboxes,
        actionButtons,
        tableForm,
        baseUrl;

    ResourcesTable.setup = function(params) {

        // Get references to HTML elements
        //
        masterCheckbox = $("#select-all");
        checkboxes = $(".table td :checkbox");
        actionButtons = $(".collection-action button");
        tableForm = $("#table-form");
        baseUrl = params.baseUrl;

        // Select or deselect all checkboxes whenever the master checkbox is clicked.
        //
        masterCheckbox.click(function() {
            checkboxes.each(function() {
                this.checked = masterCheckbox.prop("checked");
            });
            refreshButtons();
        });

        // Set master checkbox to indeterminate whenever a checkbox is clicked.
        //
        checkboxes.click(function() {
            if (masterCheckbox.is(':checked') && !$(this).is(':checked')) {
                if (someCheckboxChecked()) {
                    masterCheckbox.prop('indeterminate', true);
                } else {
                    masterCheckbox.prop('checked', false);
                    masterCheckbox.prop('indeterminate', false);
                }
            } else if (!masterCheckbox.is(':checked') && $(this).is(':checked')) {
                masterCheckbox.prop('checked', true);
                masterCheckbox.prop('indeterminate', true);
            }
            refreshButtons();
        });

        $("#select-multiple").click(actionHandler("select_multiple"));
        $("#deselect-multiple").click(actionHandler("deselect_multiple"));
        $("#destroy-multiple").click(actionHandler("destroy_multiple"));
        $("#edit-multiple").click(actionHandler("edit_multiple"));

        refreshButtons();
    };

    // Show edit and delete multiple buttons only when at least one checkbox is
    // checked.
    //
    function refreshButtons() {
        someCheckboxChecked() ? actionButtons.removeClass("disabled") : actionButtons.addClass("disabled");
    }

    function actionHandler(action) {
        var actionUrl = baseUrl + "/" + action;
        return function() {
            submit(actionUrl);
        };
    }

    function submit(actionUrl) {
        tableForm.prop('action', actionUrl);
        tableForm.submit();
    }

    function someCheckboxChecked() {
        for (var i = 0 ; i < checkboxes.length ; i++) {
            var checkbox = checkboxes.get(i);
            if (checkbox.checked)
                return true;
        }
        return false;
    }


    return ResourcesTable;
})($);
