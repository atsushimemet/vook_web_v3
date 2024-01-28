document.addEventListener('turbo:load', () => {
  // Google Chartsのロード
  google.charts.load('current', { packages: ['corechart'] });
  const pathSegments = window.location.pathname.split('/');
  const productId = pathSegments[pathSegments.length - 1];
  const priceHistogram = document.getElementById('price-histogram');

  async function drawHistogram() {
    try {
      const response = await fetch(`/api/products/${productId}`);
      const products = await response.json();

      if (products.length <= 1) {
        // データがない場合の処理
        priceHistogram.innerHTML = '';
        return;
      }

      // Google Chartsのテーブルデータを作成
      const data = new google.visualization.DataTable();
      data.addColumn('number', 'Price');
      products.forEach((product) => {
        data.addRow([product.price]);
      });

      // ヒストグラムのオプション
      const options = {
        title: '価格分布',
        titleTextStyle: {
          fontSize: 18,
        },
        chartArea: {
          left: 80,
          top: 64,
          width: '85%',
          height: '68%',
        },
        axisTitlesPosition: 'out',
        legend: { position: 'none' },
        histogram: {
          // ピンのサイズ
          bucketSize: 10000,
        },
        colors: ['#203543'],
        width: 800,
        height: 500,
        hAxis: {
          title: '価格',
          titleTextStyle: {
            italic: 'false',
          },
        },
        vAxis: {
          minValue: 0,
          title: '商品数',
          titleTextStyle: {
            italic: 'false',
          },
        },
      };

      const chart = new google.visualization.Histogram(priceHistogram);
      chart.draw(data, options);
    } catch (error) {
      console.error('Error fetching or drawing histogram:', error);
    }
  }

  if (priceHistogram) {
    google.charts.setOnLoadCallback(drawHistogram);
  }
});
