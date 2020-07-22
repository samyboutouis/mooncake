var update = false;
var num = 0;
$(document).ready(function(){
  $(".listing").on('input', function() {
    getCrossListingNum($(this));
    $("#number-choice").on('input', function() {
      getCrossListings($(this));
    })
  });

  $(".sec").on('input', function() {
    getAdditionalSectionsNum($(this));
    $("#number-choice-sec").on('input', function() {
      getAdditionalSections($(this));
    })
  });

  $("body").delegate(".custom-file-input", "change", function(){
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
  });
});

function getCrossListingNum(element) {
  let selected = element.val();
  $("#othercourses").empty();
  $("#howmany").empty();
  if (selected === "Yes") {
    $("#howmany").append($('<label/>', {
      for: 'number-choice',
      text: "How many additional departments are cross-listed with this course?"
    }));
    $("#howmany").append($('<input/>', {
      type: "number",
      min: "0",
      max: "10",
      name: "number-choice",
      id: "number-choice",
      class: "form-control"
    }));
    $("#howmany").append($('<br>'));
  }
  else {
    return;
  }
}
  
function getAdditionalSectionsNum(element) {
  let selected = element.val();
  $("#othersections").empty();
  $("#howmanysec").empty();
  if (selected === "Yes") {
    $("#howmanysec").append($('<label/>', {
      for: 'number-choice-sec',
      text: "How many additional sections?"
    }));
    $("#howmanysec").append($('<input/>', {
      type: "number",
      min: "0",
      max: "25",
      name: "number-choice-sec",
      id: "number-choice-sec",
      class: "form-control"
    }));
    $("#howmanysec").append($('<br>'));
  }
  else {
    return;
  }
}

function getCrossListings(element) {
  $.ajax('/dept', {
    type: 'GET',
    dataType: 'json',
    success: function(result) {
      let selected = element.val();
      if (selected>0) update = true;
      num = selected;
      num++;
      num++;
      $("#othercourses").empty();
      for(let i = 0; i < selected; i++) {
        $("#othercourses").append($('<h3/>', {
          style: "margin: 10px 8px 10px 0px",
          text: "Cross-listed Course " + (i+2),
        }));
        $("#othercourses").append($('<div/>', {
          class: "container-fluid",
          id: "container" + (i+1)
        }));
        $("#container" + (i+1)).append($('<div/>', {
          class: "row",
          id: "row" + (i+1)
        }));
        $("#row" + (i+1)).append($('<div/>', {
          class: "form-group col-sm-8",
          id: "col1_"+(i+1),
          style: "padding: 10px 20px 0px"
        }))
        $("#col1_"+(i+1)).append($('<label/>', {
          for: 'department'+(i+1),
          text: "Department:",
        }));
        $("#col1_"+(i+1)).append($("<select/>", {
          name: "department"+(i+1),
          class: "form-control",
          id: "department"+(i+1)
        }))
        $("#department"+(i+1)).append($('<option/>', {
          value: '',
          selected: true,
          disabled: true,
          text: 'Select One',
          class: "selection"
        }));
        for(let j = 0; j < result.length; j++){
          $("#department"+(i+1)).append($("<option/>", {
            value: result[j],
            text: result[j],
            class: "selection"
          }));
        }
        $("#row" + (i+1)).append($('<div/>', {
          class: "form-group col-sm-4",
          id: "col2_"+(i+1),
          style: "padding: 10px 20px 0px"
        }))
        $("#col2_"+(i+1)).append($('<label/>', {
          for: 'course_number'+(i+1),
          text: "Course Number:",
        }));
        $("#col2_"+(i+1)).append($('<input/>', {
          type: "text",
          name: "course_number"+(i+1),
          id: "course_number"+(i+1),
          class: "form-control",
          placeholder: "Ex: 101L"
        }));
        $("#container" + (i+1)).append($('<div/>', {
          class: "row",
          id: "row2_" + (i+1)
        }));
        $("#row2_" + (i+1)).append($('<div/>', {
          class: "form-group col",
          id: "col3_"+(i+1),
          style: "padding: 10px 20px 0px"
        }));
        $("#col3_"+(i+1)).append($('<label/>', {
          text: "Permission Number:"
        }));
        $("#col3_" + (i+1)).append($('<div/>', {
          class: "custom-file form-group",
          id: "course"+(i+1),
          style: "margin-bottom:20px;"
        }));
        $("#course"+(i+1)).append($('<input/>', {
          type: "file",
          name: "file"+(i+1),
          id: "customFile"+(i+1),
          class: "custom-file-input"
        }));
        $("#course"+(i+1)).append($('<label/>', {
          text: "Upload Permission Numbers Excel File",
          class: "custom-file-label",
          for: "customFile"+(i+1)
        }));
      }
    },
      error: function() {
      console.log('Error');
    }
  });
 }

function getAdditionalSections(element) {
  let selected = element.val();
  $("#othersections").empty();
  if (update){
    for (var i=0; i<selected; i++){
      $("#othersections").append($('<h3/>', {
        style: "margin: 10px 8px 10px 0px",
        text: "Section " + (i+2),
      }));
      $("#othersections").append($('<div/>', {
        class: "container-fluid",
        id: "container2_" + (i+1)
      }));
      $("#container2_" + (i+1)).append($('<div/>', {
        class: "row",
        id: "row3_" + (i+1)
      }));
      $("#row3_" + (i+1)).append($('<div/>', {
        class: "form-group col-sm-6",
        id: "col4_"+(i+1),
        style: "padding: 10px 20px 0px"
      }));
      $("#col4_"+(i+1)).append($('<label/>', {
        for: 'section_number'+(i+1),
        text: "Section Number:",
      }));
      $("#col4_"+(i+1)).append($('<input/>', {
        type: "text",
        name: "section_number"+(i+1),
        id: "section_number"+k,
        class: "form-control",
        placeholder: "Ex: 01-LAB"
      }));
      $("#row3_" + (i+1)).append($('<div/>', {
        class: "form-group col-sm-6",
        id: "col5_"+(i+1),
        style: "padding: 10px 20px 0px"
      }));
      $("#col5_"+(i+1)).append($('<label/>', {
        for: 'section_capacity'+(i+1),
        text: "Section Capacity:",
      }));
      $("#col5_"+(i+1)).append($('<input/>', {
        type: "number",
        name: "section_capacity"+(i+1),
        id: "section_capacity"+k,
        class: "form-control",
        placeholder: "Ex: 30"
      }));
      for (var j=0; j<=num-2; j++){
        var k = num*(i+1)+j+1;
        $("#container2_" + (i+1)).append($('<div/>', {
          class: "row",
          id: "row4_" + k
        }));
        $("#row4_" + k).append($('<div/>', {
          class: "form-group col",
          id: "col7_"+k,
          style: "padding: 10px 20px 0px"
        }));
        $("#col7_"+ k).append($('<h4/>', {
          text: "Section " + (i+2) + " For Cross-listed Course "+(j+1)
        }));
        $("#col7_"+k).append($('<label/>', {
          text: "Permission Numbers:"
        }));
        $("#col7_" + k).append($('<div/>', {
          class: "custom-file",
          id: "section"+k,
          style: "margin-bottom:20px;"
        }));
        $("#section"+k).append($('<input/>', {
          type: "file",
          name: "file"+k,
          id: "customFile"+k,
          class: "custom-file-input"
        }));
        $("#section"+k).append($('<label/>', {
          text: "Upload Permission Numbers Excel File",
          class: "custom-file-label",
          for: "customFile"+k
        }));
      }
    }
  }
  else {
    for(let i = 0; i < selected; i++) {
      $("#othersections").append($('<h3/>', {
        style: "margin: 10px 8px 10px 0px",
        text: "Section " + (i+2),
      }));
      $("#othersections").append($('<div/>', {
        class: "container-fluid",
        id: "container2_" + (i+1)
      }));
      $("#container2_" + (i+1)).append($('<div/>', {
        class: "row",
        id: "row3_" + (i+1)
      }));
      $("#row3_" + (i+1)).append($('<div/>', {
        class: "form-group col-sm-6",
        id: "col4_"+(i+1),
        style: "padding: 10px 20px 0px"
      }));
      $("#col4_"+(i+1)).append($('<label/>', {
        for: 'section_number'+(i+1),
        text: "Section Number:",
      }));
      $("#col4_"+(i+1)).append($('<input/>', {
        type: "number",
        name: "section_number"+(i+1),
        id: "section_number"+(i+1),
        class: "form-control",
        placeholder: "Ex: 30"
      }));
      $("#row3_" + (i+1)).append($('<div/>', {
        class: "form-group col-sm-6",
        id: "col5_"+(i+1),
        style: "padding: 10px 20px 0px"
      }));
      $("#col5_"+(i+1)).append($('<label/>', {
        for: 'section_capacity'+(i+1),
        text: "Section Capacity:",
      }));
      $("#col5_"+(i+1)).append($('<input/>', {
        type: "number",
        name: "section_capacity"+(i+1),
        id: "section_number"+k,
        class: "form-control",
        placeholder: "Ex: 01-LAB"
      }));
      $("#container2_" + (i+1)).append($('<div/>', {
        class: "row",
        id: "row4_" + (i+1)
      }));
      $("#row4_" + (i+1)).append($('<div/>', {
        class: "form-group col",
        id: "col6_"+(i+1),
        style: "padding: 10px 20px 0px"
      }));
      $("#col6_" + (i+1)).append($('<div/>', {
        class: "custom-file",
        id: "section"+(i+1),
        style: "margin-bottom:20px;"
      }));
      $("#section"+(i+1)).append($('<label/>', {
        text: "Permission Numbers:"
      }));
      $("#section"+(i+1)).append($('<input/>', {
        type: "file",
        name: "file"+(i+1),
        id: "customFile"+(i+1),
        class: "custom-file-input"
      }));
      $("#section"+(i+1)).append($('<label/>', {
        text: "Upload Permission Numbers Excel File",
        class: "custom-file-label",
        for: "customFile"+(i+1)
      }));
    }
  }
}