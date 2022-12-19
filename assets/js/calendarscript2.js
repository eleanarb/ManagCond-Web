﻿var currentUpdateEvent;
var addStartDate;
var addEndDate;
var globalAllDay;


$(document).ready(function () {

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    var calendar = $('#calendar').fullCalendar({
        theme: true,
        width: 'auto',
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        selectable: false,
        selectHelper: false,
        editable: false,
        events: "../Guardia/JsonResponse.ashx",

    });

});

