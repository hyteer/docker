from django.http import HttpResponse
from django.shortcuts import render
from django.core.mail import send_mail
from django.contrib.auth.decorators import login_required

def home(req):
	#return render(req, 'index.html')
	return HttpResponse('django homepage...')

################### Test #####################

def test(req):
	#return render(req, 'test.html')
	return HttpResponse('test...')
