<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chicken.model.BookInCartBean"%>
<%@page import="com.chicken.model.OrderFormBean"%>
	
<%
	//获取订单表（订单1、订单2....）
	String username=(String)session.getAttribute("username");
	ArrayList<OrderFormBean> orderBeanList=(ArrayList<OrderFormBean>)session.getAttribute(username+"_orderBeanList");

	//计算所有订单的总商品价格、总运费、总实付款
	float booksTotalPrice=0.0f; //总商品价
	float transTotalPrice=0.0f;//总运费
	float actualTotalPrice=0.0f; //总实付款
	if(orderBeanList != null)
	{
		for(int i=0;i<orderBeanList.size();i++)
		{
			OrderFormBean orderBean=orderBeanList.get(i);
			booksTotalPrice += orderBean.getOtotalbooksprice();
			transTotalPrice += orderBean.getOtotaltransprice();
		}
		actualTotalPrice=booksTotalPrice + transTotalPrice; //总实付款
	}
%>	
	
	
<div class="writeorder_info">	
	<div class="writeorder_title">
		<div class="diamond"></div><span>确认订单信息</span><br>
		<hr>
	</div>
	
	<!-- 订单1,订单2，....详情 -->
	<%
	if(orderBeanList != null)
	{
		for(int i=0;i<orderBeanList.size();i++)
		{
			OrderFormBean orderBean=orderBeanList.get(i);
			List<BookInCartBean> bookInOrderList=orderBean.getBookInCartBeanList();
			%>
			<div class="curorder_div">
			
				<div class="curorder_row_div">
				
					<!-- 订单号 -->
					<span class="font_bold_green">订单<span><%=i+1 %></span></span>		
				
					<!-- 店铺信息 -->
					<div class="curorder_row_saler_div">
						<img src="<%=orderBean.getSicon() %>"/><span><%=orderBean.getSname()%>配送</span>
						<div>
							<span>运费:￥<font><%=orderBean.getOtotaltransprice() %></font></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>小计总额:<font class="font_bold_green">￥<font><%=String.format("%.2f",orderBean.getOtotalbooksprice())%></font></font></span>
						</div>
					</div>
					
					<!-- 订单信息 -->
					<table>
						<tr>
							<td>商品信息</td>
							<td>原价</td>
							<td>单价</td>
							<td>数量</td>
							<td>小计</td>
							<td>操作</td>
						</tr>
						<% 
						for(int j=0;j<bookInOrderList.size();j++)
						{
							BookInCartBean bookInCartBean=bookInOrderList.get(j);
						%>
							<tr>
								<td><a href="DetailClServlet?dowhat=findDetail&Bid=<%=bookInCartBean.getBid()%>" target="_blank" class="book_snap"><img src="<%=bookInCartBean.getBimage() %>"/></a><span class="book_name"><%=bookInCartBean.getBname() %></span></td>
								<td><del style="color:#C9C9C9;">￥<%=bookInCartBean.getBoriprice() %></del></td>
								<td>￥<%=bookInCartBean.getBprice() %></td>
								<td><%=bookInCartBean.getTboughtnum() %></td>
								<td>￥<span><%=String.format("%.2f", bookInCartBean.getTboughtnum()*bookInCartBean.getBprice())%></span></td>
								<td><a href="javascript:void(0)" class="greenbutton" onclick="sendBookBackToCart(this)">放回购物车</a></td>
							</tr>
						<%
						}
						%>
					</table>
				</div>
			</div>
			<%
		}
		%>
			<!-- 下部分的提交订单 -->
			<div class="cart_footer" style="position: relative;right:30px;">
				<div>商品金额:<span class="font_bold_green">￥</span><span class="font_bold_green"><%=String.format("%.2f",booksTotalPrice) %></span></div>
				<div>运费:<span class="font_bold_green">￥</span><span class="font_bold_green"><%=String.format("%.2f",transTotalPrice) %></span></div>
				<div>实付款:<span class="font_big_bold_green">￥</span><span class="font_big_bold_green"><%=String.format("%.2f",actualTotalPrice) %></span></div>
				<a class="settlebtn" onclick="submitOrder()">提交订单</a>
			</div>
		<%
	}
	else
	{
		%>
			<div class='emptyorder_div'>
				<span class='font_bold_gray'>订单是空的哟~快去其它地方逛逛吧!</span><br><br>
                <a href='SearchClServlet?dowhat=searchByRand' class='green_a'>热销书籍</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href='CartClServlet?dowhat=queryCart' class='green_a'>返回购物车</a>
            </div>
		<%
	}
	%>	
</div>
