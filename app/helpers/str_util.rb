module StrUtil
    def StrUtil.null_or_empty(string_to_test)
        string_to_test.to_s.strip.length == 0
    end
end