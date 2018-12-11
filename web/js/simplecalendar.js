var calendar = {

    init: function() {

        /**
         * Get current date
         */
        var d = new Date();
        var strDate = d.getFullYear() + "/" + (d.getMonth() + 1) + "/" + d.getDate();

        /**
         * Get current month and set as '.current-month' in title
         */
        var monthNumber = d.getMonth() + 1;

        function GetMonthName(monthNumber) {
            var months = ['Januari', 'Februari', 'Mars', 'April', 'Maj', 'Juni', 'Juli', 'Augusti', 'September', 'Oktober', 'November', 'December'];
            return months[monthNumber - 1];
        }

        $('.month').text(GetMonthName(monthNumber));

        /**
         * Get current day and set as '.current-day'
         */
        $('tbody td[date-day="' + d.getDate() + '"]').addClass('current-day');

        /**
         * Add class '.active' on calendar date
         */
        $('tbody td').on('click', function(e) {
            if ($(this).hasClass('event')) {
                $('tbody td').removeClass('active');
                $(this).addClass('active');
            } else {
                $('tbody td').removeClass('active');
            };
        });

        /**
         * Add '.event' class to all days that has an event
         */
        $('.day-event').each(function(i) {
            var eventMonth = $(this).attr('date-month');
            var eventDay = $(this).attr('date-day');
            $('tbody tr td[date-month="' + eventMonth + '"][date-day="' + eventDay + '"]').addClass('event');
        });

        /**
         * Get current day on click in calendar
         * and find day-event to display
         */
        $('tbody td').on('click', function(e) {
            $('.day-event').slideUp('fast');
            var monthEvent = $(this).attr('date-month');
            var dayEvent = $(this).text();
            $('.day-event[date-month="' + monthEvent + '"][date-day="' + dayEvent + '"]').slideDown('fast');
        });

        /**
         * Close day-event
         */
        $('.close').on('click', function(e) {
            $(this).parent().slideUp('fast');
        });

        /**
         * Save & Remove to/from personal list
         */
        $('.save').click(function() {
            if (this.checked) {
                $(this).next().text('Remove from personal list');
                var eventHtml = $(this).closest('.day-event').html();
                var eventMonth = $(this).closest('.day-event').attr('date-month');
                var eventDay = $(this).closest('.day-event').attr('date-day');
                var eventNumber = $(this).closest('.day-event').attr('data-number');
                $('.person-list').append('<div class="day" date-month="' + eventMonth + '" date-day="' + eventDay + '" data-number="' + eventNumber + '" style="display:none;">' + eventHtml + '</div>');
                $('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"]').slideDown('fast');
                $('.day').find('.close').remove();
                $('.day').find('.save').removeClass('save').addClass('remove');
                $('.day').find('.remove').next().addClass('hidden-print');
                remove();
                sortlist();
            } else {
                $(this).next().text('Save to personal list');
                var eventMonth = $(this).closest('.day-event').attr('date-month');
                var eventDay = $(this).closest('.day-event').attr('date-day');
                var eventNumber = $(this).closest('.day-event').attr('data-number');
                $('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').slideUp('slow');
                setTimeout(function() {
                    $('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').remove();
                }, 1500);
            }
        });

        function remove() {
            $('.remove').click(function() {
                if (this.checked) {
                    $(this).next().text('Remove from personal list');
                    var eventMonth = $(this).closest('.day').attr('date-month');
                    var eventDay = $(this).closest('.day').attr('date-day');
                    var eventNumber = $(this).closest('.day').attr('data-number');
                    $('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').slideUp('slow');
                    $('.day-event[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').find('.save').attr('checked', false);
                    $('.day-event[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').find('span').text('Save to personal list');
                    setTimeout(function() {
                        $('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').remove();
                    }, 1500);
                }
            });
        }
    },
};

$(document).ready(function() {

    calendar.init();

});