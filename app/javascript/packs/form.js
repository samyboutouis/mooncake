$(document).ready(function(){
  $("#crosslisting").on('input', function() {
    getResponse($(this));
    $("#number-choice").on('input', function() {
      getOptions($(this));
    })
  });

  $("#sections").on('input', function() {
    getResponse2($(this));
    $("#number-choice-sec").on('input', function() {
      getOptions2($(this));
    })
  });
});

function getResponse(element) {
  let selected = element.val();
  $("#howmany").empty();
  if (selected === "Yes") {
    $("#howmany").append("<label for= 'number-choice'>How many additional courses are cross-listed?</label>");
    $("#howmany").append('<input type="text" name= "number-choice" id="number-choice" class="form-control" maxlength= 2><br>');
  }
  else {
    return;
  }
}


  
function getResponse2(element) {
  let selected = element.val();
  $("#howmanysec").empty();
  if (selected === "Yes") {
    $("#howmanysec").append("<label for= 'number-choice-sec'>How many additional sections?</label>");
    $("#howmanysec").append('<input type="text" name= "number-choice-sec" id="number-choice-sec" class="form-control" maxlength= 2><br>');
  }
  else {
    return;
  }
}

function getOptions(element) {
  const departments = ["Select One", "AAAS - African & African Amer Studies", "AEROSCI - Aerospace Studies-AFROTC", "AMES - Asian & Middle Eastern Studies", "AMI - Arts of the Moving Image", "ARABIC - Arabic", "ARTHIST - Art History", "ARTS&SCI - Arts and Science IDEAS themes", "ARTSVIS - Visual Arts", "BALTFIN - Balto-Finnic", "BIOCHEM - Biochemistry", "BIOETHIC - Bioethics and Science Policy", "BIOLOGY - Biology", "BME - Biomedical Engineering", "BRAINSOC - Brain & Society", "CEE - Civil and Environmental Egr", "CELLBIO - Cell Biology", "CESC - Civic Engagement&Social Change", "CHEM - Chemistry", "CHILDPOL - Child Policy", "CHINESE - Chinese", "CLST - Classical Studies", "COMPSCI - Computer Science", "CREOLE - Creole", "CULANTH - Cultural Anthropology", "DANCE - Dance", "DECSCI - Decision Sciences Program", "DOCST - Documentary Studies", "ECE - Electrical & Computer Egr", "ECON - Economics", "EDUC - Education", "EGR - Engineering", "EHD - Education and Human Developmnt", "ENERGY - Energy", "ENGLISH - English", "ENRGYEGR - Energy Engineering", "ENVIRON - Environment", "EOS - Earth and Ocean Sciences", "ETHICS - Study of Ethics", "EVANTH - Evolutionary Anthropology", "FOCUS - Focus", "FRENCH - French", "GENOME - Genome Sciences Policy", "GEOADMIN - Global Education Admn Use Only", "GERMAN - German", "GLHLTH - Global ", "GREEK - Greek", "GSF - Gender Sexuality & Feminist", "St HEBREW - Hebrew", "HINDI - Hindi", "HISTORY - History", "HOUSECS - House Course", "HUMANDEV - Human Development", "I&E - Innovation & Entrepreneurship", "ICS - Internatl Comparative Studies", "IDS - Interdisciplinary Data Science", "IMMUNOL - Immunology", "ISS - Information Science + Studies", "ITALIAN - Italian", "IUSC_AMI - IUSC_AMI (Taught at USC)", "IUSC_PPS - IUSC_PPS (Taught at USC)", "IUSC_THT - IUSC_THT (Taught at USC)", "JEWISHST - Jewish Studies", "JPN - Japanese", "KICHE - K'iche' Maya ", "KOREAN - Korean", "LATAMER - Latin American Studies", "LATIN - Latin", "LINGUIST - Linguistics", "LIT - Literature", "LSGS - Latino Studies Global South",  "MATH - Mathematics", "ME - Mechanical Engr/Materials Sci", "MEDREN - Medieval and Renaissance", "MGM - Molec Genetics & Microbiology", "MILITSCI - Military Science (Army ROTC) ", "MMS - Markets and Management Studies", "MUSIC - Music", "NAVALSCI - Naval Science (Navy ROTC)", "NEUROBIO - Neurobiology Neurobiology", "PATHOL - Pathology", "PERSIAN - Persian", "PHARM - Pharm and Cancer Biology", "PHIL - Philosophy", "PHYSEDU - Physical Education", "PHYSICS - Physics", "PJMS - Policy Journalism and Media St", "POE - Practice-Oriented Education", "POLISH - Polish", "POLSCI - Political Science", "PORTUGUE - Portuguese", "PSY - Psychology", "PUBPOL - Public Policy", "QUECHUA - Quechua", "REG - Registration", "RELIGION - Religion", "RIGHTS - Human Rights", "ROMANIAN - Romanian", "ROMST - Romance Studies", "RUSSIAN - Russian", "SANSKRIT - Sanskrit", "SCISOC - Science & Society", "SERBCRO - Serbian and Croatian", "SES - Slavic and Eurasian Studies", "SOCIOL - Sociology", "SPANISH - Spanish", "STA - Statistical Science", "SUSTAIN - Sustainability Engagement", "SXL - Study of Sexualities", "THEATRST - Theater Studies", "TIBETAN - Tibetan", "TURKISH - Turkish", "UKRAIN - Ukrainian", "URDU - Urdu", "UZBEK - Uzbek", "VMS - Visual and Media Studies", "WRITING - Writing"];
  let selected = element.val();
  $("#othercourses").empty();
  for(let i = 0; i < selected; i++) {
    $("#othercourses").append("<h3> Cross-listed Course " + (i+2) + "</h3>");
    $("#othercourses").append("<label for= 'department"+(i+1)+"'> Department:</label>");
    $("#othercourses").append($(document.createElement('select')).prop({
      name: "department"+(i+1),
      class: "form-control",
      id: "department"+(i+1)
    }));
    for(let j = 0; j < departments.length; j++){
      $('#department'+(i+1)).append($(document.createElement('option')).prop({
        value: departments[j],
        text: departments[j]
      }));
    }
    $("#othercourses").append('</select><br>');

    $("#othercourses").append("<label for= 'course_number"+(i+1)+"'> Course Number:</label>");
    $("#othercourses").append('<input name= "course_number'+(i+1)+'" type="text" class="form-control" id="course_number'+(i+1)+'"><br>');

    $("#othercourses").append("<label for= 'section_number"+(i+1)+"'> Section Number:</label>");
    $("#othercourses").append('<input name= "section_number'+(i+1)+'" class="form-control" type="text" id="section_number'+(i+1)+'"><br>');

    $("#othercourses").append("<label for= 'file"+(i+1)+"'> Upload Permission Numbers Excel File (xlsx) </label><br>");
    $("#othercourses").append('<input name= "file'+(i+1)+'" type="file" id="file'+(i+1)+'"><br>');
    $("#othercourses").append('<div class="spacer"></div>');
  }
}


function getOptions2(element) {
  const departments = ["Select One", "AAAS - African & African Amer Studies", "AEROSCI - Aerospace Studies-AFROTC", "AMES - Asian & Middle Eastern Studies", "AMI - Arts of the Moving Image", "ARABIC - Arabic", "ARTHIST - Art History", "ARTS&SCI - Arts and Science IDEAS themes", "ARTSVIS - Visual Arts", "BALTFIN - Balto-Finnic", "BIOCHEM - Biochemistry", "BIOETHIC - Bioethics and Science Policy", "BIOLOGY - Biology", "BME - Biomedical Engineering", "BRAINSOC - Brain & Society", "CEE - Civil and Environmental Egr", "CELLBIO - Cell Biology", "CESC - Civic Engagement&Social Change", "CHEM - Chemistry", "CHILDPOL - Child Policy", "CHINESE - Chinese", "CLST - Classical Studies", "COMPSCI - Computer Science", "CREOLE - Creole", "CULANTH - Cultural Anthropology", "DANCE - Dance", "DECSCI - Decision Sciences Program", "DOCST - Documentary Studies", "ECE - Electrical & Computer Egr", "ECON - Economics", "EDUC - Education", "EGR - Engineering", "EHD - Education and Human Developmnt", "ENERGY - Energy", "ENGLISH - English", "ENRGYEGR - Energy Engineering", "ENVIRON - Environment", "EOS - Earth and Ocean Sciences", "ETHICS - Study of Ethics", "EVANTH - Evolutionary Anthropology", "FOCUS - Focus", "FRENCH - French", "GENOME - Genome Sciences Policy", "GEOADMIN - Global Education Admn Use Only", "GERMAN - German", "GLHLTH - Global ", "GREEK - Greek", "GSF - Gender Sexuality & Feminist", "St HEBREW - Hebrew", "HINDI - Hindi", "HISTORY - History", "HOUSECS - House Course", "HUMANDEV - Human Development", "I&E - Innovation & Entrepreneurship", "ICS - Internatl Comparative Studies", "IDS - Interdisciplinary Data Science", "IMMUNOL - Immunology", "ISS - Information Science + Studies", "ITALIAN - Italian", "IUSC_AMI - IUSC_AMI (Taught at USC)", "IUSC_PPS - IUSC_PPS (Taught at USC)", "IUSC_THT - IUSC_THT (Taught at USC)", "JEWISHST - Jewish Studies", "JPN - Japanese", "KICHE - K'iche' Maya ", "KOREAN - Korean", "LATAMER - Latin American Studies", "LATIN - Latin", "LINGUIST - Linguistics", "LIT - Literature", "LSGS - Latino Studies Global South",  "MATH - Mathematics", "ME - Mechanical Engr/Materials Sci", "MEDREN - Medieval and Renaissance", "MGM - Molec Genetics & Microbiology", "MILITSCI - Military Science (Army ROTC) ", "MMS - Markets and Management Studies", "MUSIC - Music", "NAVALSCI - Naval Science (Navy ROTC)", "NEUROBIO - Neurobiology Neurobiology", "PATHOL - Pathology", "PERSIAN - Persian", "PHARM - Pharm and Cancer Biology", "PHIL - Philosophy", "PHYSEDU - Physical Education", "PHYSICS - Physics", "PJMS - Policy Journalism and Media St", "POE - Practice-Oriented Education", "POLISH - Polish", "POLSCI - Political Science", "PORTUGUE - Portuguese", "PSY - Psychology", "PUBPOL - Public Policy", "QUECHUA - Quechua", "REG - Registration", "RELIGION - Religion", "RIGHTS - Human Rights", "ROMANIAN - Romanian", "ROMST - Romance Studies", "RUSSIAN - Russian", "SANSKRIT - Sanskrit", "SCISOC - Science & Society", "SERBCRO - Serbian and Croatian", "SES - Slavic and Eurasian Studies", "SOCIOL - Sociology", "SPANISH - Spanish", "STA - Statistical Science", "SUSTAIN - Sustainability Engagement", "SXL - Study of Sexualities", "THEATRST - Theater Studies", "TIBETAN - Tibetan", "TURKISH - Turkish", "UKRAIN - Ukrainian", "URDU - Urdu", "UZBEK - Uzbek", "VMS - Visual and Media Studies", "WRITING - Writing"];
  let selected = element.val();
  $("#othersections").empty();
  for(let i = 0; i < selected; i++) {
    $("#othersections").append("<h3> Section " + (i+2) + "</h3>");
    
    $("#othersections").append("<label for= 'section_number"+(i+1)+"'> Section Number:</label>");
    $("#othersections").append('<input name= "section_number'+(i+1)+'" class="form-control" type="text" id="section_number'+(i+1)+'"><br>');

    $("#othersections").append("<label for= 'file"+(i+1)+"'> Upload Permission Numbers Excel File (xlsx) </label><br>");
    $("#othersections").append('<input name= "file'+(i+1)+'" type="file" id="file'+(i+1)+'"><br>');
    $("#othersections").append('<div class="spacer"></div>');
  }
}