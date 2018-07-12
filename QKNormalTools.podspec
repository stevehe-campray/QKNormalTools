Pod::Spec.new do |s|
s.name         = 'QKNormalTools'
s.version      = '1.0.2'
s.summary      = '工具类'
s.homepage     = 'https://github.com/stevehe-campray/QKNormalTools'
s.license      = 'MIT'
s.authors      = {'stevehe-campray' => '602258720@qq.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/stevehe-campray/QKNormalTools.git', :tag => s.version}
s.source_files = 'ToolClass/**／*.{h,m}'
s.requires_arc = true
end
