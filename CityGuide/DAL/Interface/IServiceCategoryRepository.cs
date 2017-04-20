using System;
using CityGuide.Common.Model;
using CityGuide.DAL.EntityFramework;

namespace CityGuide.DAL.Interface
{
    public interface IServiceCategoryRepository : IRepository<ServiceCategory>
    {
        PagedResult<ServiceCategory> GetFilteredServiceCategory(string categoryName, int pageNumber, int pageSize);
    }
}