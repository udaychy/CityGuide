using CityGuide.DAL;

namespace CityGuide.BLL.Base
{
    public class BusinessBase
    {
        private UnitOfWork _unitOfWork;
        public UnitOfWork UnitOfWork
        {
            get { return _unitOfWork ?? (_unitOfWork = new UnitOfWork()); }
        }
    }
}