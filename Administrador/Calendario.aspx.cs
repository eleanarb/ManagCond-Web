using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Web;

namespace ManagCond.Administrador
{
    public partial class Calendario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [System.Web.Services.WebMethod(true)]
        public static string UpdateEvent(CalendarEvent cevent)
        {
            string mensaje = "";
            List<int> idList = (List<int>)System.Web.HttpContext.Current.Session["idList"];
            if (cevent.title != "")
            {
                if (idList != null && idList.Contains(cevent.id))
                {
                    if (CheckAlphaNumeric(cevent.title) && CheckAlphaNumeric(cevent.description))
                    {
                        EventDAO.updateEvent(cevent.id, cevent.title, cevent.description);

                        mensaje = "updated event with id:" + cevent.id + " update title to: " + cevent.title +
                        " update description to: " + cevent.description;
                    }

                }
            }
            else
            {
                mensaje = "El título del evento no puede estar vacío";
            }
            return mensaje;
        }

        [System.Web.Services.WebMethod(true)]
        public static string UpdateEventTime(ImproperCalendarEvent improperEvent)
        {
            List<int> idList = (List<int>)System.Web.HttpContext.Current.Session["idList"];
            if (idList != null && idList.Contains(improperEvent.id))
            {
                EventDAO.updateEventTime(improperEvent.id,
                    DateTime.ParseExact(improperEvent.start, "dd-MM-yyyy hh:mm:ss tt", CultureInfo.InvariantCulture),
                    DateTime.ParseExact(improperEvent.end, "dd-MM-yyyy hh:mm:ss tt", CultureInfo.InvariantCulture));

                return "updated event with id:" + improperEvent.id + "update start to: " + improperEvent.start +
                    " update end to: " + improperEvent.end;
            }

            return "unable to update event with id: " + improperEvent.id;
        }

        //called when delete button is pressed
        [System.Web.Services.WebMethod(true)]
        public static String deleteEvent(int id)
        {
            //idList is stored in Session by JsonResponse.ashx for security reasons
            //whenever any event is update or deleted, the event id is checked
            //whether it is present in the idList, if it is not present in the idList
            //then it may be a malicious user trying to delete someone elses events
            //thus this checking prevents misuse
            List<int> idList = (List<int>)System.Web.HttpContext.Current.Session["idList"];
            if (idList != null && idList.Contains(id))
            {
                EventDAO.deleteEvent(id);
                return "deleted event with id:" + id;
            }

            return "unable to delete event with id: " + id;

        }

        [System.Web.Services.WebMethod]
        public static int addEvent(ImproperCalendarEvent improperEvent)
        {

            CalendarEvent cevent = new CalendarEvent()
            {
                title = improperEvent.title,
                description = improperEvent.description,
                start = DateTime.ParseExact(improperEvent.start, "dd-MM-yyyy hh:mm:ss tt", CultureInfo.InvariantCulture),
                end = DateTime.ParseExact(improperEvent.end, "dd-MM-yyyy hh:mm:ss tt", CultureInfo.InvariantCulture),
                idCond = (int)HttpContext.Current.Session["idCondominio"]

            };

            if (CheckAlphaNumeric(cevent.title) && CheckAlphaNumeric(cevent.description))
            {
                int key = EventDAO.addEvent(cevent);

                List<int> idList = (List<int>)System.Web.HttpContext.Current.Session["idList"];

                if (idList != null)
                {
                    idList.Add(key);
                }

                return key;//return the primary key of the added cevent object

            }

            return -1;//return a negative number just to signify nothing has been added

        }

        private static bool CheckAlphaNumeric(string str)
        {

            return Regex.IsMatch(str, @"^[a-zA-Z0-9 ]*$");


        }
    }
}