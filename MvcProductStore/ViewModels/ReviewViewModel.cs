﻿using System;

namespace MvcProductStore.ViewModels
{
    public class ReviewViewModel
    {
        public int Id { get; set; }
        public string Comment { get; set; }
        public string UserName { get; set; }
        public DateTime Created { get; set; }
    }
}