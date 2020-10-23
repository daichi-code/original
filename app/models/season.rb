class Season < ActiveHash::Base
  self.data = [
    { id: 1, name: '--'},
    { id: 2, name: '春・spring'},
    { id: 3, name: '夏・summer'},
    { id: 4, name: '秋・autumn'},
    { id: 5, name: '冬・winter'},
  ]
end