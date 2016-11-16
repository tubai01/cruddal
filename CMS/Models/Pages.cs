using System.Collections.Generic;

namespace CMS.Models
{
    public class Pages
    {
        public long PAGEID { get; set; }
        public string PAGENAME { get; set; }
        public string Message { get; set; }
        public List<Contents> PageContents { get; set; }
    }
}