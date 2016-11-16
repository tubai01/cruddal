namespace CMS.Models
{
    public class Contents
    {
        public long ID { get; set; }
        public long PAGEID { get; set; }
        public string HEADER { get; set; }
        public string FOOTER { get; set; }
        public string TOP { get; set; }
        public string MIDDLE { get; set; }
        public string BOTTOM { get; set; }

        public string Message { get; set; }
    }
}