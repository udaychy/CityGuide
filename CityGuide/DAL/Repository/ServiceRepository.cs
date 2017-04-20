using CityGuide.Common.Model;
using CityGuide.DAL.EntityFramework;
using CityGuide.DAL.Interface;

namespace CityGuide.DAL.Repository
{
    public class ServiceRepository : Repository<Service>, IServiceRepository
    {
        private readonly CityGuideEntities _context;

         public ServiceRepository(CityGuideEntities context)
            : base(context)
        {
            _context = context;
        }

    }
}