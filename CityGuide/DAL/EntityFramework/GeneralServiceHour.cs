//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CityGuide.DAL.EntityFramework
{
    using System;
    using System.Collections.Generic;
    
    public partial class GeneralServiceHour
    {
        public int Id { get; set; }
        public int ServiceId { get; set; }
        public string Day { get; set; }
        public Nullable<System.TimeSpan> OpeningTime { get; set; }
        public Nullable<System.TimeSpan> ClosingTime { get; set; }
        public Nullable<System.TimeSpan> BreakTimeStart { get; set; }
        public Nullable<System.TimeSpan> BreakTimeEnd { get; set; }
    
        public virtual Service Service { get; set; }
    }
}