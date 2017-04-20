using CityGuide.DAL.EntityFramework;
using CityGuide.DAL.Repository;
using CityGuide.DAL.Interface;

namespace CityGuide.DAL
{
    public class UnitOfWork
    {
        private readonly CityGuideEntities _context;

        public UnitOfWork()
        {
            _context = new CityGuideEntities();
        }

        private IServiceCategoryRepository  _serviceCategoryRepository;
        public IServiceCategoryRepository ServiceCategoryRepository
        {
            get { return _serviceCategoryRepository ?? (_serviceCategoryRepository = new ServiceCategoryRepository(_context)); }
        }

        private IServiceRepository _serviceRepository;
        public IServiceRepository ServiceRepository
        {
            get { return _serviceRepository ?? (_serviceRepository = new ServiceRepository(_context)); }
        }

        public int Commit()
        {
           return _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}