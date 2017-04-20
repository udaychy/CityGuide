using System.Linq;
using System.Runtime.Hosting;
using CityGuide.Common.Model;
using CityGuide.Common.Utility;
using CityGuide.DAL;
using System.Data.Entity;
using CityGuide.DAL.EntityFramework;
using CityGuide.DAL.Interface;

namespace CityGuide.DAL.Repository
{
    public class ServiceCategoryRepository : Repository<ServiceCategory>, IServiceCategoryRepository
    {
         private readonly CityGuideEntities _context;

         public ServiceCategoryRepository(CityGuideEntities context)
            : base(context)
        {
            _context = context;
        }

         public PagedResult<ServiceCategory> GetFilteredServiceCategory(string categoryName, int pageNumber, int pageSize)
        {
            return BaseFilterSearchQuery(categoryName).AsNoTracking().Page(pageNumber, pageSize);
        }

         private IQueryable<ServiceCategory> BaseFilterSearchQuery(string categoryName)
         {
             var categoryNameFilter = !string.IsNullOrEmpty(categoryName);
             IQueryable<ServiceCategory> filterQuery = _context.ServiceCategories.Where(x => !(bool)x.IsDeleted);
            
             if (categoryNameFilter) filterQuery = filterQuery.Where(x => x.Name.Contains(categoryName) || x.Description.Contains(categoryName));
            
             return filterQuery;
         }
    }
}