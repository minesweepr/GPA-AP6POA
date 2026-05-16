document.addEventListener("DOMContentLoaded", function () {

    if (!window.eventos) {
        console.error("Eventos não carregaram");
        return;
    }

    function corAleatoria() {
        const cores = [
            "#1a73e8",
            "#d93025",
            "#f9ab00",
            "#188038",
            "#a142f4",
            "#ff6d00",
            "#00acc1"
        ];

        return cores[Math.floor(Math.random() * cores.length)];
    }

    const eventosComCor = window.eventos.map(e => ({
        ...e,
        backgroundColor: corAleatoria(),
        borderColor: corAleatoria()
    }));

    const calendarEl = document.getElementById("calendar");

    if (!calendarEl) {
        console.error("Div #calendar não existe");
        return;
    }

    const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: "dayGridMonth",
        locale: "pt-br",
        buttonText: { today: "Hoje" },
        height: "auto",
        events: eventosComCor,
        eventClick: function (info) {
            info.jsEvent.preventDefault();
            if (info.event.url) {
                window.open(info.event.url, "_blank");
            }
        },
        eventTimeFormat: {
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        },
        displayEventTime: true,
        slotLabelFormat: {
            hour: '2-digit',
            minute: '2-digit'
        },
        dayMaxEvents: true,
        moreLinkClick: 'popover',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        stickyHeaderDates: false
    });

    calendar.render();
});