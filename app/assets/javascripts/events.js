function change(id){
    join_button = document.getElementById("join"+id)
    leave_button = document.getElementById("leave"+id)
    if (join_button.hidden == true) {
        join_button.hidden = false
        leave_button.hidden = true
    }
    else {
        leave_button.hidden = false
        join_button.hidden = true
    }
}

function inactive_on_delete(id){
    control = document.getElementById("control-buttons"+id)
    control.hidden = true
}


  