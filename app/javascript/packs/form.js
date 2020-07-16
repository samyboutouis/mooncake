var sec = 0;
var cl = 0;
$(document).ready(function(){
  $(".listing").on('input', function() {
    getResponse($(this));

    $("#number-choice").on('input', function() {
      getOptions1($(this));
    })
    $("#number-choice-sec").on('input', function() {
      getOptions2($(this));
    })

    $("#number-choice-1").on('input', function() {
      console.log($(this).val().length);
      if ($(this).val().length == 0) {
        cl = 0
      }
      else {
        cl = parseInt($(this).val());
      };
      getOptions3(cl);
    })
    $("#number-choice-sec-1").on('input', function() {
      if ($(this).val().length == 0) {
        sec = 0
      }
      else {
        sec = parseInt($(this).val());
      };
      getOptions4(sec);
    })
  })

  $("body").delegate(".custom-file-input", "change", function(){
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
  });
});

function getResponse(element) {
  let selected = element.val();
  console.log(selected)
  $("#upload").empty();
  $("#othersections").empty();
  $("#othercourses").empty();
  $("#howmanysec").empty();
  $("#howmany").empty();
  if (selected === "Cross-listed and has multiple sections") {
    $("#howmany").append("<label for= 'number-choice-1'>How many additional departments are cross-listed with this course?</label>");
    $("#howmany").append('<input type="number" name= "number-choice-1" id="number-choice-1" class="form-control" maxlength= 2><br>');
    $("#howmanysec").append("<label for= 'number-choice-sec-1'>How many additional sections?</label>");
    $("#howmanysec").append('<input type="number" name= "number-choice-sec-1" id="number-choice-sec-1" class="form-control" maxlength= 2><br>');
  }
  if (selected === "Cross-listed only") {
    $("#howmany").append("<label for= 'number-choice'>How many additional departments are cross-listed with this course?</label>");
    $("#howmany").append('<input type="number" max=10 name= "number-choice" id="number-choice" class="form-control" maxlength= 2><br>');
  }
  if (selected === "Multiple sections only") {
    $("#howmanysec").append("<label for= 'number-choice-sec'>How many additional sections?</label>");
    $("#howmanysec").append('<input type="number" name= "number-choice-sec" id="number-choice-sec" class="form-control" maxlength= 2><br>');
  }
}

function getOptions1(element) {
  $.ajax('/dept', {
    type: 'GET',
    dataType: 'json',
    success: function(result) {
      let selected = element.val();
      $("#othercourses").empty();
      for(let i = 0; i < selected; i++) {
        $("#othercourses").append("<h3 style='margin: 10px 8px 10px 0px'> Cross-listed Course " + (i+2) + "</h3>");
        $("#othercourses").append("<label for= 'department"+(i+1)+"'> Department:</label>");
        $("#othercourses").append($(document.createElement('select')).prop({
          name: "department"+(i+1),
          class: "form-control",
          id: "department"+(i+1),
        }));
        $("#department"+(i+1)).append("<option value='' disabled selected> Select One </option>");
        for(let j = 0; j < result.length; j++){
          $('#department'+(i+1)).append($(document.createElement('option')).prop({
            value: result[j],
            text: result[j]
          }));
        }
        $("#othercourses").append('</select><br>');
        $("#othercourses").append("<label for= 'course_number"+(i+1)+"'> Course Number:</label>");
        $("#othercourses").append('<input name= "course_number'+(i+1)+'" type="text" class="form-control" id="course_number'+(i+1)+'"><br>');
        
        $("#othercourses").append("<label for= 'section_number"+(i+1)+"'> Section Number:</label>");
        $("#othercourses").append('<input name= "section_number'+(i+1)+'" class="form-control" type="text" id="section_number'+(i+1)+'"><br>');
        
        $("#othercourses").append("<label> Permission Numbers:</label>");
        $("#othercourses").append('<div class="custom-file" id="course'+(i+1)+'" style="margin-bottom:20px;">');
        $("#othercourses #course"+(i+1)).append('<input name= "file'+(i+1)+'" type="file" class="custom-file-input" id="customFile'+(i+1)+'">');
        $("#othercourses #course"+(i+1)).append('<label class="custom-file-label" for="customFile'+(i+1)+'">Upload Permission Numbers Excel File</label>');
        $("#othercourses").append('</div>');
      }
    },
      error: function() {
      console.log('Error');
    }
  });
 }

function getOptions2(element) {
  // departments = ["Select One", "AAAS - African & African Amer Studies", "AEROSCI - Aerospace Studies-AFROTC", "AMES - Asian & Middle Eastern Studies", "AMI - Arts of the Moving Image", "ARABIC - Arabic", "ARTHIST - Art History", "ARTS&SCI - Arts and Science IDEAS themes", "ARTSVIS - Visual Arts", "BALTFIN - Balto-Finnic", "BIOCHEM - Biochemistry", "BIOETHIC - Bioethics and Science Policy", "BIOLOGY - Biology", "BME - Biomedical Engineering", "BRAINSOC - Brain & Society", "CEE - Civil and Environmental Egr", "CELLBIO - Cell Biology", "CESC - Civic Engagement&Social Change", "CHEM - Chemistry", "CHILDPOL - Child Policy", "CHINESE - Chinese", "CLST - Classical Studies", "COMPSCI - Computer Science", "CREOLE - Creole", "CULANTH - Cultural Anthropology", "DANCE - Dance", "DECSCI - Decision Sciences Program", "DOCST - Documentary Studies", "ECE - Electrical & Computer Egr", "ECON - Economics", "EDUC - Education", "EGR - Engineering", "EHD - Education and Human Developmnt", "ENERGY - Energy", "ENGLISH - English", "ENRGYEGR - Energy Engineering", "ENVIRON - Environment", "EOS - Earth and Ocean Sciences", "ETHICS - Study of Ethics", "EVANTH - Evolutionary Anthropology", "FOCUS - Focus", "FRENCH - French", "GENOME - Genome Sciences Policy", "GEOADMIN - Global Education Admn Use Only", "GERMAN - German", "GLHLTH - Global ", "GREEK - Greek", "GSF - Gender Sexuality & Feminist", "St HEBREW - Hebrew", "HINDI - Hindi", "HISTORY - History", "HOUSECS - House Course", "HUMANDEV - Human Development", "I&E - Innovation & Entrepreneurship", "ICS - Internatl Comparative Studies", "IDS - Interdisciplinary Data Science", "IMMUNOL - Immunology", "ISS - Information Science + Studies", "ITALIAN - Italian", "IUSC_AMI - IUSC_AMI (Taught at USC)", "IUSC_PPS - IUSC_PPS (Taught at USC)", "IUSC_THT - IUSC_THT (Taught at USC)", "JEWISHST - Jewish Studies", "JPN - Japanese", "KICHE - K'iche' Maya ", "KOREAN - Korean", "LATAMER - Latin American Studies", "LATIN - Latin", "LINGUIST - Linguistics", "LIT - Literature", "LSGS - Latino Studies Global South", "MATH - Mathematics", "ME - Mechanical Engr/Materials Sci", "MEDREN - Medieval and Renaissance", "MGM - Molec Genetics & Microbiology", "MILITSCI - Military Science (Army ROTC) ", "MMS - Markets and Management Studies", "MUSIC - Music", "NAVALSCI - Naval Science (Navy ROTC)", "NEUROBIO - Neurobiology Neurobiology", "PATHOL - Pathology", "PERSIAN - Persian", "PHARM - Pharm and Cancer Biology", "PHIL - Philosophy", "PHYSEDU - Physical Education", "PHYSICS - Physics", "PJMS - Policy Journalism and Media St", "POE - Practice-Oriented Education", "POLISH - Polish", "POLSCI - Political Science", "PORTUGUE - Portuguese", "PSY - Psychology", "PUBPOL - Public Policy", "QUECHUA - Quechua", "REG - Registration", "RELIGION - Religion", "RIGHTS - Human Rights", "ROMANIAN - Romanian", "ROMST - Romance Studies", "RUSSIAN - Russian", "SANSKRIT - Sanskrit", "SCISOC - Science & Society", "SERBCRO - Serbian and Croatian", "SES - Slavic and Eurasian Studies", "SOCIOL - Sociology", "SPANISH - Spanish", "STA - Statistical Science", "SUSTAIN - Sustainability Engagement", "SXL - Study of Sexualities", "THEATRST - Theater Studies", "TIBETAN - Tibetan", "TURKISH - Turkish", "UKRAIN - Ukrainian", "URDU - Urdu", "UZBEK - Uzbek", "VMS - Visual and Media Studies", "WRITING - Writing"];
  let selected = element.val();
  $("#othersections").empty();
  for(let i = 0; i < selected; i++) {
    $("#othersections").append("<h3> Section " + (i+2) + "</h3>");
    
    $("#othersections").append("<label for= 'section_number"+(i+1)+"'> Section Number:</label>");
    $("#othersections").append('<input name= "section_number'+(i+1)+'" class="form-control" type="text" id="capacity'+(i+1)+'"><br>');

    $("#othersections").append("<label for= 'capacity"+(i+1)+"'> Capacity:</label>");
    $("#othersections").append('<input name= "capacity'+(i+1)+'" class="form-control" type="number" id="capacity'+(i+1)+'"><br>');

    $("#othersections").append("<label> Permission Numbers:</label>");
    $("#othersections").append('<div class="custom-file" id="section'+(i+1)+'" style="margin-bottom:20px;">');
    $("#othersections #section"+(i+1)).append('<input name= "file'+(i+1)+'" type="file" class="custom-file-input" id="customFile'+(i+1)+'">');
    $("#othersections #section"+(i+1)).append('<label class="custom-file-label" for="customFile'+(i+1)+'">Upload Permission Numbers Excel File</label>');
    $("#othersections").append('</div>');
  }
}

function getOptions3(cl) {
  $.ajax('/dept', {
    type: 'GET',
    dataType: 'json',
    success: function(result) {
      $("#othercourses").empty();
      $("#upload").empty();
      for(let i = 0; i < cl; i++) {
        $("#othercourses").append("<h3 style='margin: 10px 8px 10px 0px'> Cross-listed Course " + (i+2) + "</h3>");
        $("#othercourses").append("<label for= 'department"+(i+1)+"'> Department:</label>");
        $("#othercourses").append($(document.createElement('select')).prop({
          name: "department"+(i+1),
          class: "form-control",
          id: "department"+(i+1),
        }));
        $("#department"+(i+1)).append("<option value='' disabled selected> Select One </option>");
        for(let j = 0; j < result.length; j++){
          $('#department'+(i+1)).append($(document.createElement('option')).prop({
            value: result[j],
            text: result[j]
          }));
        }
        $("#othercourses").append('</select><br>');
        $("#othercourses").append("<label for= 'course_number"+(i+1)+"'> Course Number:</label>");
        $("#othercourses").append('<input name= "course_number'+(i+1)+'" type="text" class="form-control" id="course_number'+(i+1)+'"><br>');
        
        // $("#othercourses").append("<label for= 'section_number"+(i+1)+"'> Section Number:</label>");
        // $("#othercourses").append('<input name= "section_number'+(i+1)+'" class="form-control" type="text" id="section_number'+(i+1)+'"><br>');
        
        // $("#othercourses").append("<label> Permission Numbers:</label>");
        // $("#othercourses").append('<div class="custom-file" id="course'+(i+1)+'" style="margin-bottom:20px;">');
        // $("#othercourses #course"+(i+1)).append('<input name= "file'+(i+1)+'" type="file" class="custom-file-input" id="customFile'+(i+1)+'">');
        // $("#othercourses #course"+(i+1)).append('<label class="custom-file-label" for="customFile'+(i+1)+'">Upload Permission Numbers Excel File</label>');
        // $("#othercourses").append('</div>');
      }   
      uploadNum(cl, sec)
    },
    error: function() {
    console.log('Error');
    }
  });
}

function getOptions4(sec) {
  $("#othersections").empty();
  $("#upload").empty();
  for(let i = 0; i < sec; i++) {
    $("#othersections").append("<h3> Section " + (i+2) + "</h3>");
    
    $("#othersections").append("<label for= 'section_number"+(i+1)+"'> Section Number:</label>");
    $("#othersections").append('<input name= "section_number'+(i+1)+'" class="form-control" type="text" id="capacity'+(i+1)+'"><br>');

    $("#othersections").append("<label for= 'capacity"+(i+1)+"'> Capacity:</label>");
    $("#othersections").append('<input name= "capacity'+(i+1)+'" class="form-control" type="number" id="capacity'+(i+1)+'"><br>');

    // $("#othersections").append("<label> Permission Numbers:</label>");
    // $("#othersections").append('<div class="custom-file" id="section'+(i+1)+'" style="margin-bottom:20px;">');
    // $("#othersections #section"+(i+1)).append('<input name= "file'+(i+1)+'" type="file" class="custom-file-input" id="customFile'+(i+1)+'">');
    // $("#othersections #section"+(i+1)).append('<label class="custom-file-label" for="customFile'+(i+1)+'">Upload Permission Numbers Excel File</label>');
    // $("#othersections").append('</div>');
  }
  uploadNum(cl, sec)
}

function uploadNum(cl, sec) {
  $("#upload").empty();
  let k = 1
  for(let i = 1; i <= (cl+1); i++) {
    for(let j = 1; j <= (sec+1); j++) {
      if (i != 1 || j != 1) {
        $("#upload").append("<h3> Course " +i+ " Section " +j+"</h3>");

        $("#upload").append("<label> Permission Numbers:</label>");
        $("#upload").append('<div class="custom-file" id="files'+(k)+'" style="margin-bottom:20px;">');
        $("#upload #files"+(k)).append('<input name= "file'+(k)+'" type="file" class="custom-file-input" id="customFile'+(k)+'">');
        $("#upload #files"+(k)).append('<label class="custom-file-label" for="customFile'+(k)+'">Upload Permission Numbers Excel File</label>');
        $("#upload").append('</div>');
        k++
      }
    }
  }
}