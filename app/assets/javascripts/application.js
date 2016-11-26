//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require_tree .

function moveEvent(event, dayDelta, minuteDelta, allDay){
    jQuery.ajax({
        data: 'id=' + event.id + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&authenticity_token=' + authenticity_token,
        dataType: 'script',
        type: 'post',
        url: "/events/move"
    });
}

function resizeEvent(event, dayDelta, minuteDelta){
    jQuery.ajax({
        data: 'id=' + event.id + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&authenticity_token=' + authenticity_token,
        dataType: 'script',
        type: 'post',
        url: "/events/resize"
    });
}

function showEventDetails(event){
    if (event.client_name) {
      $('#event_desc').html("Client Name: " + event.client_name + 
                            "<br>Client's Phone Number: " + event.phone_number +
                            "<br>APT Number: " + event.apt_number +
                            "<br>Current Tenant: " + event.current_tenant);
    } else {
      $('#event_desc').html("Not Scheduled Yet");
    }
    
    $('#edit_event').html("<a href = 'javascript:void(0);' onclick ='editEvent(" + event.id + ")'>Edit</a>");
    if (event.recurring) {
        title = event.title + "(Recurring)";
        $('#delete_event').html("&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete Only This Occurrence</a>");
        $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + true + ")'>Delete All In Series</a>")
        $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", \"future\")'>Delete All Future Events</a>")
    }
    else {
        title = event.ca_name;
        $('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete</a>");
    }
    $('#desc_dialog').dialog({
        title: "CA: " + event.ca_name,
        modal: true,
        width: 400,
        close: function(event, ui){
            $('#desc_dialog').dialog('destroy')
        }
        
    });
    
}


function editEvent(event_id){
    jQuery.ajax({
      url: "/events/" + event_id + "/edit",
      success: function(data) {
        $('#event_desc').html(data['form']);
      } 
    });
}

function deleteEvent(event_id, delete_all){
  jQuery.ajax({
    data: 'authenticity_token=' + authenticity_token + '&delete_all=' + delete_all,
    dataType: 'script',
    type: 'delete',
    url: "/events/" + event_id,
    success: refetch_events_and_close_dialog
  });
}

function refetch_events_and_close_dialog() {
  $('#calendar').fullCalendar( 'refetchEvents' );
  $('.dialog:visible').dialog('destroy');
}

function showPeriodAndFrequency(value){

    switch (value) {
        case 'Daily':
            $('#period').html('day');
            $('#frequency').show();
            break;
        case 'Weekly':
            $('#period').html('week');
            $('#frequency').show();
            break;
        case 'Monthly':
            $('#period').html('month');
            $('#frequency').show();
            break;
            
        default:
            $('#frequency').hide();
    }
    
    
    
    
}

$(document).ready(function(){
  $('#create_event_dialog, #desc_dialog').on('submit', "#event_form", function(event) {
    var $spinner = $('.spinner');
    event.preventDefault();
    $.ajax({
      type: "POST",
      data: $(this).serialize(),
      url: $(this).attr('action'),
      beforeSend: show_spinner,
      complete: hide_spinner,
      success: refetch_events_and_close_dialog,
      error: handle_error
    });

    function show_spinner() {
      $spinner.show();
    }

    function hide_spinner() {
      $spinner.hide();
    }

    function handle_error(xhr) {
      alert(xhr.responseText);
    }
  })
});