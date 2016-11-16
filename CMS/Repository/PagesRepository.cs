using CMS.Models;
using System.Collections.Generic;

namespace CMS.Repository
{
    public class PagesRepository
    {
        DataAccessLayer.CRUDDAL objDataAccess = new DataAccessLayer.CRUDDAL();
        public List<Pages> CreateNewPages(Pages pages)
        {
            string PageId = "";
            List<DataAccessLayer.Parameters> lstParameters = new List<DataAccessLayer.Parameters>();
            lstParameters.Add(objDataAccess.AddParameter("@PageName", pages.PAGENAME));
            List<Pages> lstPages = objDataAccess.CRUD<Pages>("CreateNewPages", lstParameters);
            if (lstPages[0].Message.ToString() != "Already Exists")
            {
                lstParameters = new List<DataAccessLayer.Parameters>();
                foreach (var content in pages.PageContents)
                {
                    PageId = lstPages[0].Message.ToString();
                    lstParameters.Add(objDataAccess.AddParameter("@PAGEID", PageId));

                    lstParameters.Add(objDataAccess.AddParameter("@HEADER", content.HEADER));

                    lstParameters.Add(objDataAccess.AddParameter("@Top", content.TOP));

                    lstParameters.Add(objDataAccess.AddParameter("@MIDDLE", content.MIDDLE));

                    lstParameters.Add(objDataAccess.AddParameter("@BOTTOM", content.BOTTOM));


                    lstParameters.Add(objDataAccess.AddParameter("@FOOTER", content.FOOTER));


                    List<Contents> lstContents = objDataAccess.CRUD<Contents>("CreateNewContents", lstParameters);
                }
            }
            return lstPages;
        }

        public List<Pages> getPages()
        {
            List<Pages> lstPages = objDataAccess.CRUD<Pages>("getPages");
            return lstPages;
        }
        public List<Contents> getPagecontents()
        {
            List<Contents> lstPageContents = objDataAccess.CRUD<Contents>("getPagecontents");
            return lstPageContents;
        }
    }
}