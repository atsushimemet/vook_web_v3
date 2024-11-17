import * as React from 'react';
import { Chart } from 'react-google-charts';
import useSWR from 'swr';
import Skeleton from '@mui/material/Skeleton';

const fetcher = (url) => fetch(url).then((res) => res.json());

export default function PriceHistogram() {
  const url = new URL(window.location.href);
  const productId = url.pathname.split('/').pop();
  const { data: products, error } = useSWR(
    `/api/products/${productId}`,
    fetcher,
    {
      revalidateOnFocus: false,
    },
  );

  const isLoading = !products && !error;

  const histogramData = React.useMemo(() => {
    if (!products) return [['Product', 'Price']];
    return [
      ['Product', 'Price'],
      ...products.map((product) => [product.name, product.price]),
    ];
  }, [products]);

  const chartOptions = {
    titleTextStyle: { fontSize: 14 },
    chartArea: { left: 80, top: 32, width: '85%', height: '70%' },
    legend: { position: 'none' },
    histogram: { bucketSize: 10000 },
    colors: ['#203543'],
    backgroundColor: '#f2f4f7',
    hAxis: { title: '価格', titleTextStyle: { italic: false } },
    vAxis: { title: '商品数', minValue: 0, titleTextStyle: { italic: false } },
  };

  if (error) return <div>Error loading data</div>;

  return (
    <div className="chartContainer">
      <div className="chartBox" style={{ minHeight: '400px' }}>
        {isLoading ? (
          <Skeleton variant="rectangular" width="100%" height="400px" />
        ) : (
          <Chart
            chartType="Histogram"
            width="100%"
            height="400px"
            data={histogramData}
            options={chartOptions}
          />
        )}
      </div>
    </div>
  );
}
