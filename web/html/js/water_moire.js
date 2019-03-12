canvas = document.getElementById("c");
ctx  = canvas.getContext("2d");
oRange = document.getElementsByName("range")[0];
M = Math;
Sin = M.sin;
Cos = M.cos;
Sqrt = M.sqrt;
Pow = M.pow;
PI = M.PI;
Round = M.round;
oW = canvas.width = 250;
oH = canvas.height = 250;
// 线宽
lineWidth = 2;
// 大半径
r = (oW / 2);
cR = r - 10*lineWidth;
ctx.beginPath();
ctx.lineWidth = lineWidth;
// 水波动画初始参数
axisLength = 2*r - 16*lineWidth;  // Sin 图形长度
unit = axisLength / 9; // 波浪宽
range = .4 // 浪幅
nowrange = range;  
xoffset = 8*lineWidth; // x 轴偏移量

data = 0.3;   // 数据量

sp = 0; // 周期偏移量
nowdata = 0;
waveupsp = 0.006; // 水波上涨速度
// 圆动画初始参数
arcStack = [];  // 圆栈
bR = r-8*lineWidth;
soffset = -(PI/2); // 圆动画起始位置
circleLock = true; // 起始动画锁
// 获取圆动画轨迹点集
for(var i = soffset; i< soffset + 2*PI; i+=1/(8*PI)) {
  arcStack.push([
    r + bR * Cos(i),
    r + bR * Sin(i)
  ])
}
// 圆起始点
cStartPoint = arcStack.shift();  
ctx.strokeStyle = "#1c86d1";
ctx.moveTo(cStartPoint[0],cStartPoint[1]);
// 开始渲染
render();  
function drawSine () {
  ctx.beginPath();
  ctx.save();
  var Stack = []; // 记录起始点和终点坐标
  for (var i = xoffset; i<=xoffset + axisLength; i+=20/axisLength) {
    var x = sp + (xoffset + i) / unit;
    var y = Sin(x) * nowrange;
    var dx = i;
    var dy = 2*cR*(1-nowdata) + (r - cR) - (unit * y);
    ctx.lineTo(dx, dy);
    Stack.push([dx,dy])
  }
  // 获取初始点和结束点
  var startP = Stack[0]
  var endP = Stack[Stack.length - 1]
  ctx.lineTo(xoffset + axisLength,oW);
  ctx.lineTo(xoffset,oW);
  ctx.lineTo(startP[0], startP[1])
  ctx.fillStyle = "#6d88cb";
  ctx.fill();
  ctx.restore();
}

function drawText () {
  ctx.globalCompositeOperation = 'source-over';
  var size = 0.4*cR;
  ctx.font = size + 'px mengna';
  txt = (nowdata.toFixed(2)*100).toFixed(0) + '度';
  var fonty = r + size/2;
  var fontx = r - size * 0.8;
  ctx.textAlign = 'center';
  ctx.fillText(txt, r+5, r+20)
}
//最外面淡黄色圈
function drawCircle(){
  ctx.beginPath();
  ctx.lineWidth = 15;
  ctx.strokeStyle = '#97A6CB';
  ctx.arc(r, r, cR+7, 0, 2 * Math.PI);
  ctx.stroke();
  ctx.restore();
}
//灰色圆圈
function grayCircle(){
  ctx.beginPath();
  ctx.lineWidth = 10;
  ctx.strokeStyle = '#ddd';
  ctx.arc(r, r, cR-5, 0, 2 * Math.PI);
  ctx.stroke();
  ctx.restore();
  ctx.beginPath();
}
//橘黄色进度圈
function orangeCircle(){
  ctx.beginPath();
  ctx.strokeStyle = '#6d88cb';
  //使用这个使圆环两端是圆弧形状
  ctx.lineCap = 'round';
  ctx.arc(r, r, cR-5,0 * (Math.PI / 180.0) - (Math.PI / 2),(nowdata * 360) * (Math.PI / 180.0) - (Math.PI / 2));
  ctx.stroke();
  ctx.save()
}
//裁剪中间水圈
function clipCircle(){
  ctx.beginPath();
  ctx.arc(r, r, cR-10, 0, 2 * Math.PI,false);
  ctx.clip();
}
//渲染canvas
function render () {
  ctx.clearRect(0,0,oW,oH);
  //最外面淡黄色圈
  drawCircle();
  //灰色圆圈  
  grayCircle();
  //橘黄色进度圈
  orangeCircle();
  //裁剪中间水圈  
  clipCircle();
  // 控制波幅
  oRange.addEventListener("change", function () {
      data = ~~(oRange.value) / 100;
      console.log("data="+data)
    },0);
  if (data >= 0.85) {
    if (nowrange > range/4) {
      var t = range * 0.01;
      nowrange -= t;   
    }
  } else if (data <= 0.1) {
    if (nowrange < range*1.5) {
      var t = range * 0.01;
      nowrange += t;   
    }
  } else {
    if (nowrange <= range) {
      var t = range * 0.01;
      nowrange += t;   
    }      
    if (nowrange >= range) {
      var t = range * 0.01;
      nowrange -= t;
    }
  }
  if((data - nowdata) > 0) {
    nowdata += waveupsp;      
  }
  if((data - nowdata) < 0){
    nowdata -= waveupsp
  }
  sp += 0.07;
  // 开始水波动画
  drawSine();
  // 写字
  drawText();  
  requestAnimationFrame(render)
}