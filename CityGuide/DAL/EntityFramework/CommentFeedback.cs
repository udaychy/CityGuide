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
    
    public partial class CommentFeedback
    {
        public int Id { get; set; }
        public int FeedbackId { get; set; }
        public int UserId { get; set; }
        public Nullable<bool> Like { get; set; }
        public Nullable<bool> Dislike { get; set; }
        public System.DateTime CreatedOn { get; set; }
    
        public virtual Feedback Feedback { get; set; }
        public virtual User User { get; set; }
    }
}