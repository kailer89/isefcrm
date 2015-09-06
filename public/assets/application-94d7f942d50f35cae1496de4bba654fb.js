//
// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery_ujs
//= require jquery
//= require bootstrap
//= require jquery.ui.all
//= require bootstrap
//= require wysihtml5
//= require bootstrap-wysihtml5
//= require formToWizard
//= require bwizard
//= require jquery.metadata
//= require jquery.tablesorter
//= require_tree .
window.onload=function(){function a(a){$(a).prev("input[type=hidden]").val("1"),$(a).closest(".fields").hide()}function b(a,b,c){var d=(new Date).getTime(),e=new RegExp("new_"+b,"g");$(a).parent().before(c.replace(e,d))}function c(a,b){var c;c="/"+a+"/"+b+"/printview",window.open(c,"_printview","height=800,width=800,status=no,menubar=no,location=no,toolbar=no")}$(function(){$(window).scroll(function(){$(this).scrollTop()!=0?$("#toTop").fadeIn():$("#toTop").fadeOut()}),$("#toTop").click(function(){$("body,html").animate({scrollTop:0},800)})}),$(window).bind("load",function(){location.href.indexOf("users")!=-1&&($footer=$("#gc-footer"),$footer.hide())})}