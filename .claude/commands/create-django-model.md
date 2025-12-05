---
argument-hint: [app-name] [model-name] [model-name-snake] [custom-instruction]
description: Create a new Django model
---

# Create Django Model

Create a new Django model named {{model_name}} following an opinionated checklist.

**Arguments:**

- `app-name` - The django app in which to create the new model
- `model-name` - CamelCase name (e.g., TeamProject)
- `model-name-snake` - snake_case version (e.g., team_project)
- `custom-instruction` - Any custom instructions (fields, etc.)

**Example:** `/create-model e_coach TeamProject team_project`

## Instructions

**IMPORTANT: Complete ALL 9 steps below. Do not skip any step.**

### 1. The Model

- Create the model file `{{app_name}}/models/{{model_name_snake}}.py`
- Create the model class inheriting from `UUIDModel` and `TimeStampedModel`
- Define the `__str__` method
- Import the model in `{{app_name}}/models/__init__.py`

Example model structure:

```python
# {{app_name}}/models/{{model_name_snake}}.py
from django.db import models
from core.models import UUIDModel
from django_extensions.db.models import TimeStampedModel


class {{model_name}}(UUIDModel, TimeStampedModel):
    title = models.CharField(max_length=512)
    description = models.CharField(max_length=2000, null=True, blank=True)
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name="{{model_name_snake}}s")

    def __str__(self):
        return self.title
```

### 2. The Migration

- Generate the migration: `docker compose run --rm api python manage.py makemigrations {{app_name}}`
- Review the generated migration file
- Execute the migration: `docker compose run --rm api python manage.py migrate`

### 3. Model Tests

- Create test file `{{app_name}}/tests/models/test_{{model_name_snake}}.py`
- Create model test class
- Implement tests:
  - `test_can_create_a_{{model_name_snake}}`
  - `test_can_print_a_{{model_name_snake}}`

Example test structure:

```python
# {{app_name}}/tests/models/test_{{model_name_snake}}.py
from django.test import TestCase
from {{app_name}}.models import {{model_name}}
from accounts.models import User

class Test{{model_name}}(TestCase):
    def test_can_create_a_{{model_name_snake}}(self):
        {{model_name_snake}} = {{model_name}}(
            title="title",
            description="description",
            created_by=User.objects.create(email="email@example.com")
        )

        {{model_name_snake}}.full_clean()
        {{model_name_snake}}.save()

    def test_can_print_a_{{model_name_snake}}(self):
        {{model_name_snake}} = {{model_name}}(
            title="title",
            description="description",
            created_by=User.objects.create(email="email@example.com")
        )
        expected_str = "title"

        self.assertEqual(str({{model_name_snake}}), expected_str)
```

### 4. Factory

- Create factory file `{{app_name}}/tests/factories/{{model_name_snake}}_factory.py`
- Use `factory.Faker()` for generating dummy data
- Import factory in `{{app_name}}/tests/factories/__init__.py`

Example factory:

```python
# {{app_name}}/tests/factories/{{model_name_snake}}_factory.py
import factory
from {{app_name}} import models
from accounts.tests.factories import UserFactory

class {{model_name}}Factory(factory.django.DjangoModelFactory):
    title = factory.Faker("sentence", nb_words=5)
    description = factory.Faker("text", max_nb_chars=300)
    created_by = factory.SubFactory(UserFactory)

    class Meta:
        model = models.{{model_name}}
```

### 5. Factory Tests

- Add factory test to the model test file `{{app_name}}/tests/models/test_{{model_name_snake}}.py`
- Test factory functionality
- Verify object creation works correctly

Example test (add to Test{{model_name}} class):

```python
# {{app_name}}/tests/models/test_{{model_name_snake}}.py
from {{app_name}}.tests.factories import {{model_name}}Factory

class Test{{model_name}}(TestCase):
    # ... other tests ...

    def test_factory_can_create_{{model_name_snake}}(self):
        {{model_name_snake}} = {{model_name}}Factory()
        self.assertIsNotNone({{model_name_snake}}.id)
```

### 6. Admin Pages

- Create admin file `{{app_name}}/admin/{{model_name_snake}}_admin.py`
- Create admin class
- Override `get_queryset` to use `select_related` or `prefetch_related` if the model contains ForeignKey or ManyToManyField
- Import admin in `{{app_name}}/admin/__init__.py`

Example admin:

```python
# {{app_name}}/admin/{{model_name_snake}}_admin.py
from django.contrib import admin
from {{app_name}}.models import {{model_name}}

@admin.register({{model_name}})
class {{model_name}}Admin(admin.ModelAdmin):
    list_display = ["title", "created_by", "created"]
    search_fields = ["title", "description"]
    list_filter = ["created"]

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        queryset = queryset.select_related("created_by")
        return queryset
```

### 7. Admin Page Tests

- Create admin test file `{{app_name}}/tests/admin/test_{{model_name_snake}}_admin.py`
- Test changelist, add, and change pages
- Include query count assertions to prevent N+1 queries

Example test:

```python
# {{app_name}}/tests/admin/test_{{model_name_snake}}_admin.py
from django.test import TestCase, Client
from django.urls import reverse
from {{app_name}}.tests import factories


class Test{{model_name}}Admin(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = factories.UserFactory(is_superuser=True)
        cls.{{model_name_snake}}s = factories.{{model_name}}Factory.create_batch(6)

    def setUp(self):
        self.client.force_login(self.user)

    def test_changelist(self):
        url = reverse("admin:{{app_name}}_{{model_name_snake}}_changelist")

        with self.assertNumQueries(5):  # Make sure this number doesn't increase if the number of objects created in setUpTestData increases.
            response = self.client.get(url)

        self.assertEqual(response.status_code, 200)

    def test_add(self):
        url = reverse("admin:{{app_name}}_{{model_name_snake}}_add")

        with self.assertNumQueries(5):
            response = self.client.get(url)

        self.assertEqual(response.status_code, 200)

    def test_change(self):
        url = reverse(
            "admin:{{app_name}}_{{model_name_snake}}_change", kwargs={"object_id": self.{{model_name_snake}}s[0].id}
        )

        with self.assertNumQueries(5):
            response = self.client.get(url)

        self.assertEqual(response.status_code, 200)
```

### 8. Run Tests

- Run the tests for the app: `docker compose run --rm api python manage.py test {{app_name}}`
- If tests fail, fix the issues (update tests, fix imports, adjust model code, etc.) and re-run tests
- Iterate until all tests pass

### 9. Format Code

- Run `nformat` to format code with black, isort and fix flake8 issues
