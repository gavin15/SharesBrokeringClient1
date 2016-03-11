<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
   Gavin Shares Brokering 
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>Gavin Shares Brokering </h1>
            </hgroup>
            <p>
            </p>
        </div>
    </section>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <h3>We suggest the following:</h3>
    <ol class="round">
        <li class="one">
            <h5>Buy Shares</h5>
            Buy shares from the share market
            <br />
        </li>

        <li class="two">
            <h5>Sell Shares</h5>
            Sell shares to the market
            <br />
        </li>

        <li class="three">
            <h5>List Shares</h5>
            List the shares
            <br />
        </li>
    </ol>
</asp:Content>
