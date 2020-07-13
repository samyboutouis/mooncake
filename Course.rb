require 'httparty'

class Course
end
    
    def course_search

        key = ENV["ACCESS_TOKEN"]

        response0 = HTTParty.get("https://streamer.oit.duke.edu/curriculum/list_of_values/fieldname/SUBJECT?access_token=" + key)
        subjects = JSON.parse(response0.body)
        subjects = subjects["scc_lov_resp"]["lovs"]["lov"]["values"]["value"]
        
        departments = []
        for sub in subjects
            departments.append(sub["code"] + " - " + sub["desc"])
        end

        # Change values
        code = "ARTSVIS"
        desc = "Visual Arts"
        course_number = " 223"


        desc = desc.split(" ")
        if desc.include? "&"
            desc[desc.index("&")] =  "%26"
        end
        desc = desc.join("%20")
        
        response = HTTParty.get("https://streamer.oit.duke.edu/curriculum/courses/subject/"+code+ "%20-%20"+desc+"?access_token=" +key )
        course = JSON.parse(response.body)
        course = course["ssr_get_courses_resp"]["course_search_result"]["subjects"]["subject"]["course_summaries"]["course_summary"]
        for c in course
            if c["catalog_nbr"] == course_number
                courseid = c["crse_id"]
                offer_nbr = c["crse_offer_nbr"]
            end
        end

        # Change values
        session_code = "1"
        class_section = "01"
        term_no = "1710"
        term = "2020 Spring Term" # HAS TO BE IN FORMAT: YEAR SEASON TERM (NO#)
        
        
        term = term.split(" ")
        if term.include? "&"
            term[term.index("&")] =  "%26"
        end
        term = term.join("%20")
        
        response2 = HTTParty.get("https://streamer.oit.duke.edu/curriculum/classes/strm/"+ term_no + "%20-%20" + term + "/crse_id/" + courseid +"/crse_offer_nbr/" + offer_nbr + "/session_code/" + session_code + "/class_section/" + class_section + "?access_token=" +key )
        course2 = JSON.parse(response2.body)
        course2 = course2["ssr_get_class_section_resp"]["class_section_result"]["class_sections"]["ssr_class_section"]
        capacity = course2["enrl_cap"]
        seats_taken = course2["enrl_tot"]
        course_status = course2["enrl_status_descr"]
        puts capacity
        puts seats_taken
        puts course_status

        cl = []
        crosslisting = course2["class_combined_section"]["combined_section"]
        for crse_crossed in crosslisting
            cl.append(crse_crossed["ssr_classname_long"])
        end
        puts cl

    end

    course_search()




