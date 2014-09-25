import unittest
import os
import testLib

class TestAddOldUser(testLib.RestTestCase):
    """Test adding an already existing user"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.ERR_USER_EXISTS):
        expected = {'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'neo', 'password' : 'password' } )
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'neo', 'password' : 'password' } ) 
        self.assertResponse(respData)

class TestBadUsername(testLib.RestTestCase):
    """Test adding a user with an invalid username"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.ERR_BAD_USERNAME):
        expected = {'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd2(self):
        respData = self.makeRequest("/users/add", method = "POST", data = { 'user': 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'passwor' : 'password' } )
        self.assertResponse(respData)

class TestBlankUsername(testLib.RestTestCase):
    """Test adding a user with a blank username"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.ERR_BAD_USERNAME):
        expected = {'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd3(self):
        respData = self.makeRequest("/users/add", method = "POST", data = { 'user': '', 'password' : 'password' } )
        self.assertResponse(respData)

class TestBadPassword(testLib.RestTestCase):
    """Test adding a user with an invalid password"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD):
        expected = {'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testAdd4(self):
        respData = self.makeRequest("/users/add", method = "POST", data = { 'user': 'trinity', 'password' : 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' } )
        self.assertResponse(respData)

class TestLoginUser(testLib.RestTestCase):
    """Test logging in a user"""
    def assertResponse(self, respData, count = 2, errCode = testLib.RestTestCase.SUCCESS):
        expected = {'errCode' : errCode }
        if count is not None:
            expected['count'] = count
        self.assertDictEqual(expected, respData)

    def testLogin1(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'morpheus', 'password' : 'password' } )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'morpheus', 'password' : 'password' } )
        self.assertResponse(respData, count = 2)

class TestLoginNonExistingUser(testLib.RestTestCase):
    """Test logging in a non-existent user"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        expected = {'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testLogin2(self):
        respData = self.makeRequest("/users/login", method="POST", data = {'user': 'cipher', 'password': 'password' } )
        self.assertResponse(respData)
    
