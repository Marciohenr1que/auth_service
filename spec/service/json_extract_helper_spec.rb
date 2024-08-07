require 'rails_helper'
RSpec.describe Auth::TokenExtractHelper, type: :lib do
    let(:payload) { { user_id: 1, some_data: 'test' } }
    let(:exp) { 1.hour.from_now }
    let(:encoded_token) { Auth::TokenExtractHelper.encode(payload, exp) }
    
    describe '.encode' do
      it 'codifica o payload em um token JWT' do
        expect { encoded_token }.not_to raise_error
      end
  
      it 'inclui o campo exp no payload' do
        decoded = JWT.decode(encoded_token, Auth::TokenExtractHelper::SECRET_KEY)[0]
        expect(decoded['exp']).to be_within(1.minute).of(exp.to_i)
      end
    end
  
    describe '.decode' do
      it 'decodifica um token JWT corretamente' do
        decoded_payload = Auth::TokenExtractHelper.decode(encoded_token)
        expect(decoded_payload['user_id']).to eq(payload[:user_id])
        expect(decoded_payload['some_data']).to eq(payload[:some_data])
      end
  
      it 'retorna nil se o token for inválido' do
        invalid_token = "invalid.token"
        expect(Auth::TokenExtractHelper.decode(invalid_token)).to be_nil
      end
  
      it 'retorna nil se o token expirou' do
        expired_token = Auth::TokenExtractHelper.encode(payload, 1.minute.ago)
        expect(Auth::TokenExtractHelper.decode(expired_token)).to be_nil
      end
    end
  end