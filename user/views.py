# myapp/views.py
from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from .models import People


def get_users(request):
    # Get all users from the database
    users = People.objects.all()
    data = [{'id': user.id, 'name': user.name, 'address': user.address} for user in users]
    return JsonResponse(data, safe=False)


@csrf_exempt
def add_user(request):
    if request.method == 'POST':
        # Get the data from the request body
        data = request.POST

        # Extract name and address from the data
        name = data.get('name')
        address = data.get('address')

        # Perform basic validation (you can add more validation as needed)
        if not name or not address:
            return JsonResponse({'error': 'Name and address are required.'}, status=400)

        # Create a new user in the database
        user = People.objects.create(name=name, address=address)

        # Return the newly created user data
        return JsonResponse({'id': user.id, 'name': user.name, 'address': user.address}, status=201)

    return JsonResponse({'error': 'Invalid request method.'}, status=405)
