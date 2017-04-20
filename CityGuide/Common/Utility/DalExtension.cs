using System;
using System.Linq;
using CityGuide.Common.Model;

namespace CityGuide.Common.Utility
{
    public static class DalExtensions
    {
        public static PagedResult<T> Page<T>(this IQueryable<T> query, int pageNumber, int pageSize)
        {
            var result = new PagedResult<T>
            {
                CurrentPage = pageNumber,
                PageSize = pageSize,
                RowCount = query.Count(),
                Results = query.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList()
            };
            result.PageCount = (int)Math.Ceiling((double)result.RowCount / pageSize);
            return result;
        }
    }
}
