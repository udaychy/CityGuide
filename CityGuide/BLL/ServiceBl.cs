using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CityGuide.Common.Constant;
using CityGuide.BLL.Base;
using CityGuide.Common.Model;
using CityGuide.DAL.EntityFramework;

namespace CityGuide.BLL
{
    public class ServiceBl : BusinessBase
    {
        public PagedResult<ServiceCategory> GetFilteredServiceCategory(string categoryName, int pageNumber)
        {
            return UnitOfWork.ServiceCategoryRepository.GetFilteredServiceCategory(categoryName, pageNumber, ServiceCatagoryConstant.PageSize);
        }
    }
}