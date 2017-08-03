sf = ScaleFinder('axes');

sf.xSize = 500;
sf.ySize = 500;

sf.trySet('pixels','xAxisX',100);
sf.trySet('pixels','xAxisY',1);
sf.trySet('pixels','yAxisX',1);
sf.trySet('pixels','yAxisY',100);

sf.trySet('values','xAxisX',500);
sf.trySet('values','yAxisY',1000);

sf.printData
sf